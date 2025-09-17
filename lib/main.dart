import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const Animeflix());
}

class Animeflix extends StatefulWidget {
  const Animeflix({super.key});

  @override
  State<Animeflix> createState() => _AnimeflixState();
}

class _AnimeflixState extends State<Animeflix> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A), // noir profond
        primaryColor: const Color(0xFFE50914), // rouge shōnen
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0A0A),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF0A0A0A),
          selectedItemColor: Color(0xFFE50914),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
      ),
      home: Scaffold(
        body: IndexedStack( // ✅ évite de recréer les pages à chaque clic
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Recherche"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          ],
        ),
      ),
    );
  }
}
