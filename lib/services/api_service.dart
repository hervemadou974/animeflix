import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class ApiService {
  static Future<List<Anime>> fetchAnimes() async {
    final url = Uri.parse("https://api.jikan.moe/v4/seasons/2025/fall");
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
}
