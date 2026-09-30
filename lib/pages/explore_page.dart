import 'package:flutter/material.dart';
import 'package:projetagro/data/products.dart';
import 'package:projetagro/widgets/product_card.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ ampidiro

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String searchQuery = "";
  String selectedCategory = "Tout";

  final categories = ["Tout", "Légumes", "Fruits", "Céréales"];

  // ✅ Lisitra numéros
  final phoneNumbers = [
    "0334302919",
    "0380651391",
    "0322203312",
  ];

  Future<void> _callNumber(String number) async {
    final Uri url = Uri(scheme: "tel", path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Impossible d'appeler le $number")),
      );
    }
  }

  void _showPhoneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choisir un numéro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: phoneNumbers.map((num) {
              return ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: Text(num),
                onTap: () {
                  Navigator.pop(context); // Akatona ilay dialog
                  _callNumber(num); // Miantso ilay numéro
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final name = product.name.toLowerCase();
      final query = searchQuery.toLowerCase();
      final matchText = name.contains(query);
      final matchCategory =
          selectedCategory == "Tout" || product.category == selectedCategory;
      return matchText && matchCategory;
    }).toList();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔍 Barre de recherche ...
          // ...

          // 🟩 Section promo
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              height: 170,
              child: Card(
                color: Colors.green.shade200,
                elevation: 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Consultation gratuite",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.green.shade700),
                            ),
                            const Text("Obtenez une assistance gratuite de notre service"),
                            FilledButton(
                              onPressed: _showPhoneDialog, // ✅ Appel numéro
                              child: const Text("Appeler maintenant"),
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/Ispm.png', width: 140),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ... ambiny code produits
        ],
      ),
    );
  }
}
