import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class ApiService {
  static Future<List<Anime>> fetchSeason({
    required int year,
    required String season, // "summer", "fall", "winter", "spring"
    int page = 1,
  }) async {
    final url = Uri.parse("https://api.jikan.moe/v4/seasons/$year/$season?page=$page");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> animes = jsonData['data'];

      // ✅ base de liens custom (plus tard tu peux les charger depuis un JSON)
      final customLinks = {
        "One Piece": ["https://sekai.one/one-piece"],
        "Naruto": ["https://sekai.one/naruto"],
      };

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
          links: customLinks[anime['title']] ?? [],
        );
      }).toList();
    } else {
      throw Exception("Erreur API Jikan: ${response.statusCode}");
    }
  }
}
