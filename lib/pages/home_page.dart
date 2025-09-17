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
  late Future<List<Anime>> _futureAnimes;

  @override
  void initState() {
    super.initState();
    _futureAnimes = ApiService.fetchAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("AnimeFlix")),
      body: FutureBuilder<List<Anime>>(
        future: _futureAnimes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          }

          final animes = snapshot.data ?? [];
          final grouped = groupByGenre(animes);

          return ListView(
            children: grouped.entries.map((entry) {
              final genre = entry.key;
              final genreAnimes = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
                        crossAxisCount: 3, // ✅ 3 colonnes
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final anime = genreAnimes[index];
                        return AnimeCard(anime: anime); // ✅ cartes réutilisables
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
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
