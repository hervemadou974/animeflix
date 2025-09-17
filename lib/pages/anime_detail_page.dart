import 'package:flutter/material.dart';
import '../models/anime.dart';

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(anime.image, height: 300),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              anime.genre,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(anime.synopsis),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text("Lire"),
            )
          ],
        ),
      ),
    );
  }
}
