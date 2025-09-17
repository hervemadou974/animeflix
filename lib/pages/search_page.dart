import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/api_service.dart';
import '../widgets/anime_grid_paginated.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  Future<List<Anime>> _fetchAnimes(int page) {
    return ApiService.fetchAnimes(); // ✅ sans paramètre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Catalogue"),
        backgroundColor: const Color(0xFF0A0A0A),
      ),
      body: AnimeGridPaginated(
        fetchPage: _fetchAnimes,
        crossAxisCount: 3,
        childAspectRatio: 0.6,
      ),
    );
  }
}
