import 'package:flutter/material.dart';
import '../services/api_service.dart';       // <--- important
import '../widgets/anime_grid_paginated.dart';
import '../models/anime.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  Future<List<Anime>> _fetchAnimes(int page) async {
    return ApiService.fetchAnimes(page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Catalogue")),
      body: AnimeGridPaginated(fetchPage: _fetchAnimes),
    );
  }
}
