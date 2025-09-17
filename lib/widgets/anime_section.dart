import 'package:flutter/material.dart';
import '../models/anime.dart';
import 'anime_row_paginated.dart';

class AnimeSection extends StatelessWidget {
  final String title;
  final Future<List<Anime>> Function(int page) fetchPage;

  const AnimeSection({
    super.key,
    required this.title,
    required this.fetchPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          AnimeRowPaginated(fetchPage: fetchPage),
        ],
      ),
    );
  }
}
