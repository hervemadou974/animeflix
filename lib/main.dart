import 'package:flutter/material.dart';
import 'pages/splash_page.dart';

void main() {
  runApp(const Animeflix());
}

class Animeflix extends StatelessWidget {
  const Animeflix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        primaryColor: const Color(0xFFE50914),
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
      home: const SplashPage(), // ✅ démarre sur le Splash
    );
  }
}
