import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(AnimeFlixApp());
}

class AnimeFlixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimeFlix',
      theme: ThemeData.dark(useMaterial3: true),
      home: HomePage(),
    );
  }
}
