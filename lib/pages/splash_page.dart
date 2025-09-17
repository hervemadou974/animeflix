import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'main_app.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    // 🎵 Joue le son
    _player.play(AssetSource('sounds/katana_slash.wav'));

    // ⏳ Attends 2 secondes puis redirige vers MainApp
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          "assets/images/animeflix.png", // assure-toi que le fichier existe bien
          width: 180,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
