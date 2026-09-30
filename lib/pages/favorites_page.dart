import 'package:flutter/material.dart';
import 'package:projetagro/data/favorites.dart';
import 'package:projetagro/models/product.dart';
import 'package:projetagro/pages/product_details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Favoris "),
      ),
      body: favoriteItems.isEmpty
          ? const Center(child: Text("Aucun favori pour le moment"))
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          Product product = favoriteItems[index];
          return ListTile(
            leading: Image.asset(product.image, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(product.name),
            subtitle: Text("${product.price} Ar /${product.unit}"),
            trailing: const Icon(Icons.favorite, color: Colors.green),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
