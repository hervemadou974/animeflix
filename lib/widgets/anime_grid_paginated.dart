import 'package:flutter/material.dart';
import '../models/anime.dart';
import 'anime_card.dart';

/// Grille d'animes avec scroll infini (pagination)
/// 
/// Exemple d'utilisation :
/// AnimeGridPaginated(
///   fetchPage: (page) => ApiService.fetchAnimes(page: page),
/// )
class AnimeGridPaginated extends StatefulWidget {
  final Future<List<Anime>> Function(int page) fetchPage;
  final int crossAxisCount;
  final double childAspectRatio;

  const AnimeGridPaginated({
    super.key,
    required this.fetchPage,
    this.crossAxisCount = 3,
    this.childAspectRatio = 0.6,
  });

  @override
  State<AnimeGridPaginated> createState() => _AnimeGridPaginatedState();
}

class _AnimeGridPaginatedState extends State<AnimeGridPaginated> {
  final List<Anime> _animes = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadPage();
    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadPage();
      }
    });
  }

  Future<void> _loadPage() async {
    setState(() => _isLoading = true);
    try {
      final newAnimes = await widget.fetchPage(_currentPage);

      setState(() {
        if (newAnimes.isEmpty) {
          _hasMore = false;
        } else {
          _currentPage++;
          _animes.addAll(newAnimes);
        }
      });
    } catch (e) {
      debugPrint("Erreur lors du chargement page $_currentPage: $e");
      setState(() => _hasMore = false);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _controller,
      padding: const EdgeInsets.all(8),
      physics: const AlwaysScrollableScrollPhysics(), // ✅ scroll activé
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: _animes.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _animes.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return AnimeCard(anime: _animes[index]);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
