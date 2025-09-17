import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/api_service.dart';
import 'anime_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animeflix")),
      body: FutureBuilder<List<Anime>>(
        future: ApiService.fetchAnimes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          }

          final animes = snapshot.data ?? [];

          return ListView.builder(
            itemCount: animes.length,
            itemBuilder: (context, index) {
              final anime = animes[index];
              return ListTile(
                leading: Image.network(anime.image, width: 50),
                title: Text(anime.title),
                subtitle: Text(anime.genre),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AnimeDetailPage(anime: anime),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
