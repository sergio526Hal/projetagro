import 'package:flutter/material.dart';
import 'package:projetagro/data/products.dart';
import 'package:projetagro/widgets/product_card.dart';

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    // Filtrer les produits selon catégorie sy recherche
    final filteredProducts = products.where((p) {
      final matchCategory = p.category == widget.category;
      final matchSearch =
      p.name.toLowerCase().contains(query.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Rechercher un produit...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // ✅ Résultats
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
              child: Text("Aucun produit trouvé "),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredProducts.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
