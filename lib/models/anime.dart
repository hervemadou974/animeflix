class Anime {
  final String title;
  final String genre;
  final String image;
  final String synopsis;
  final List<String> links; // ✅ liens streaming

  Anime({
    required this.title,
    required this.genre,
    required this.image,
    required this.synopsis,
    this.links = const [],
  });
}
