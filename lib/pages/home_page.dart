import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/api_service.dart';
import '../widgets/anime_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Anime>> _futureSummer;
  late Future<List<Anime>> _futureFall;

  @override
  void initState() {
    super.initState();
    _futureSummer = ApiService.fetchSeason(year: 2025, season: "summer");
    _futureFall   = ApiService.fetchSeason(year: 2025, season: "fall");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("AnimeFlix")),
      body: ListView(
        children: [
          _buildSeasonSection("Summer 2025", _futureSummer),
          _buildSeasonSection("Fall 2025", _futureFall),
        ],
      ),
    );
  }

  Widget _buildSeasonSection(String seasonTitle, Future<List<Anime>> future) {
    return FutureBuilder<List<Anime>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Erreur: ${snapshot.error}"));
        }

        final animes = snapshot.data ?? [];
        final grouped = groupByGenre(animes);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seasonTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              ...grouped.entries.map((entry) {
                final genre = entry.key;
                final genreAnimes = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        genre,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: genreAnimes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          final anime = genreAnimes[index];
                          return AnimeCard(anime: anime);
                        },
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Map<String, List<Anime>> groupByGenre(List<Anime> animes) {
    final Map<String, List<Anime>> grouped = {};
    for (final anime in animes) {
      final genres = anime.genre.split(", ");
      for (final g in genres) {
        if (g.isEmpty) continue;
        grouped.putIfAbsent(g, () => []);
        grouped[g]!.add(anime);
      }
    }
    return grouped;
  }
}
