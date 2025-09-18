import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../pages/anime_detail_page.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AnimeDetailPage(anime: anime),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              anime.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            anime.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
