import 'package:url_launcher/url_launcher.dart';
import '../utils/slugify.dart';

Future<void> openOnSekaione(String title) async {
  final slug = toSlug(title);
  final url = Uri.parse("https://sekai.one/");

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    // fallback Google si jamais ça ne marche pas
    final googleUrl = Uri.parse("https://www.google.com/search?q=$title anime");
    await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
  }
}
