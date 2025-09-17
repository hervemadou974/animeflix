import 'package:flutter/material.dart';
import '../models/anime.dart';
import 'anime_card.dart';

/// Rangée horizontale avec scroll infini (pagination)
/// Style "bibliothèque manga"
class AnimeRowPaginated extends StatefulWidget {
  final Future<List<Anime>> Function(int page) fetchPage;
  final double cardWidth;
  final double cardHeight;

  const AnimeRowPaginated({
    super.key,
    required this.fetchPage,
    this.cardWidth = 120,
    this.cardHeight = 180,
  });

  @override
  State<AnimeRowPaginated> createState() => _AnimeRowPaginatedState();
}

class _AnimeRowPaginatedState extends State<AnimeRowPaginated> {
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
              _controller.position.maxScrollExtent - 100 &&
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
      debugPrint("Erreur chargement page $_currentPage: $e");
      setState(() => _hasMore = false);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.cardHeight + 40, // image + titre
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: _animes.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _animes.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Container(
            width: widget.cardWidth,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            child: AnimeCard(anime: _animes[index]),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
