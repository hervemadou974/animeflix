import 'package:flutter/material.dart';
import '../models/anime.dart';
import 'anime_card.dart';

class AnimeGrid extends StatelessWidget {
  final List<Anime> animes;
  final int crossAxisCount;   // nombre de colonnes
  final double childAspectRatio; // ratio largeur/hauteur

  const AnimeGrid({
    super.key,
    required this.animes,
    this.crossAxisCount = 3,
    this.childAspectRatio = 0.6,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,           // évite les scroll infinis
      physics: const NeverScrollableScrollPhysics(), // pour l'utiliser dans un SingleChildScrollView
      itemCount: animes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return AnimeCard(anime: animes[index]);
      },
    );
  }
}
