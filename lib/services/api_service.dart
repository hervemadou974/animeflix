import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class ApiService {
  /// Récupérer une saison (été, automne, hiver, printemps)
  static Future<List<Anime>> fetchSeason({
    required int year,
    required String season, // "summer", "fall", "winter", "spring"
    int page = 1,
  }) async {
    final url =
        Uri.parse("https://api.jikan.moe/v4/seasons/$year/$season?page=$page");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> animes = jsonData['data'];

      return animes.map((anime) {
        final genres = (anime['genres'] as List<dynamic>?)
                ?.map((g) => g['name'] as String)
                .toList() ??
            [];

        return Anime(
          title: anime['title'] ?? "",
          genre: genres.join(", "),
          image: anime['images']?['jpg']?['large_image_url'] ?? "",
          synopsis: anime['synopsis'] ?? "Aucun synopsis disponible",
        );
      }).toList();
    } else {
      throw Exception("Erreur API Jikan: ${response.statusCode}");
    }
  }

  /// Alias pratique pour SearchPage (par ex. Fall 2025)
  static Future<List<Anime>> fetchAnimes({int page = 1}) {
    return fetchSeason(year: 2025, season: "fall", page: page);
  }
}

