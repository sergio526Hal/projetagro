import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projetagro/data/cart.dart';
import 'package:projetagro/data/favorites.dart'; // 🌟 ampidiro
import 'package:projetagro/models/product.dart';
import 'package:projetagro/pages/cart_page.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool showMore = false;
  late TapGestureRecognizer readMoreGestureRecognizer;
  int quantity = 1;

  @override
  void initState() {
    readMoreGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showMore = !showMore;
        });
      };
    super.initState();
  }

  @override
  void dispose() {
    readMoreGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = favoriteItems.contains(widget.product);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  favoriteItems.remove(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Retiré des favoris")),
                  );
                } else {
                  favoriteItems.add(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ajouté aux favoris")),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 400,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.product.image),
              ),
            ),
          ),
          Text(widget.product.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Disponible en stock", style: TextStyle(fontSize: 16, color: Colors.green)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.product.price} Ar ",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: "/${widget.product.unit}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.star, size: 27, color: Colors.yellowAccent.shade700),
              Text("${widget.product.rating} (192)"),
              const Spacer(),
              IconButton.filled(
                onPressed: () {
                  setState(() {
                    if (quantity > 1) quantity--;
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text("$quantity ${widget.product.unit}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
              IconButton.filled(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text("Description",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: showMore
                      ? widget.product.description
                      : "${widget.product.description.substring(0, widget.product.description.length > 100 ? 100 : widget.product.description.length)}...",
                ),
                TextSpan(
                  recognizer: readMoreGestureRecognizer,
                  text: showMore ? " Lire moins" : " En savoir plus",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              for (int i = 0; i < quantity; i++) {
                cartItems.add(widget.product);
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            label: const Text("Ajouter au panier"),
            icon: const Icon(Icons.shopping_bag),
          ),
        ],
      ),
    );
  }
}
