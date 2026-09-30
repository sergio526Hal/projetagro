import 'package:flutter/material.dart';
import 'package:projetagro/pages/cart_page.dart';
import 'package:projetagro/pages/explore_page.dart';
import 'package:projetagro/pages/profile_page.dart';
import 'package:projetagro/pages/services_page.dart';
import 'package:projetagro/pages/favorites_page.dart'; // ✅ Import favoris

class HomePage extends StatefulWidget {
  final Function(bool)? onThemeChanged; // callback avy any amin'ny main

  const HomePage({super.key, this.onThemeChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    const ExplorePage(),
    const ServicesPage(),
    const CartPage(),
    const ProfilePage(),
  ];
  int currentIndex = 0;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Paramètres',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // 🌙 Mode sombre
            SwitchListTile(
              title: const Text("Mode sombre"),
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
                widget.onThemeChanged?.call(value);
              },
              secondary: const Icon(Icons.dark_mode),
            ),


            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.green),
              title: const Text("Mes Favoris"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesPage(),
                  ),
                );
              },
            ),

            // 🌍 Langue
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Langue"),
              onTap: () {
                // TODO: logique de changement de langue
              },
            ),

            // ℹ️ A propos
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("À propos"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Agro-Business",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 Agro Team",
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Agro-Business ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Profitez de notre service",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.green),
            ),
          ),
        ],
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.room_service), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Panier'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
