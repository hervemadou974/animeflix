import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../utils/url_launcher.dart';

class AnimeDetailPage extends StatelessWidget {
  final Anime anime;

  const AnimeDetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(anime.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(anime.image, height: 250),
            ),
            const SizedBox(height: 16),
            Text(
              anime.synopsis,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 20),

            // 🔗 Bouton vers Sekai.one
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914),
              ),
              onPressed: () => openOnSekaione(anime.title),
              icon: const Icon(Icons.open_in_new, color: Colors.white),
              label: const Text(
                "Voir sur Sekai.one",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
