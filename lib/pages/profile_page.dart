import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=12", // avatar factice
              ),
            ),
            const SizedBox(height: 12),
            const Text("Utilisateur", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text("Paramètres"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white),
              title: const Text("Favoris"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text("Déconnexion"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
