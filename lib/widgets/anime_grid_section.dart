import 'package:flutter/material.dart';
import '../models/anime.dart';
import 'anime_grid_paginated.dart';

class AnimeGridSection extends StatelessWidget {
  final String title;
  final Future<List<Anime>> Function(int page) fetchPage;
  final int crossAxisCount;

  const AnimeGridSection({
    super.key,
    required this.title,
    required this.fetchPage,
    this.crossAxisCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: AnimeGridPaginated(
            fetchPage: fetchPage,
            crossAxisCount: crossAxisCount,
          ),
        ),
      ],
    );
  }
}
