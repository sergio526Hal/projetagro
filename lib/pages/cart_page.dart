import 'package:flutter/material.dart';
import 'package:projetagro/data/cart.dart'; // Assure-toi que cartItems est une liste globale
import 'package:projetagro/models/product.dart';
import 'package:projetagro/widgets/cart_item.dart'; // Ton widget CartItem
import 'package:projetagro/pages/payment_page.dart'; // 👉 Ataovy misy ity PaymentPage

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeItem(Product item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = cartItems;
    final totalPrice = items.fold(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
      ),
      body: items.isEmpty
          ? const Center(child: Text("Votre panier est vide"))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔁 Affichage des articles du panier
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CartItem(
              cartItem: item,
              onRemove: () => removeItem(item), // 🔗 Supprimer
            ),
          )),
          const SizedBox(height: 15),

          // 🧮 Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total (${items.length})"),
              Text(
                "${totalPrice.toStringAsFixed(2)} Ar",
                style:
                Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ✅ Bouton paiement
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    totalAmount: totalPrice,
                  ),
                ),
              );
            },
            label: const Text("Procéder au paiement"),
            icon: const Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
