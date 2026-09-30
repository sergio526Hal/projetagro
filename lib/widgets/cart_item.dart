import 'package:flutter/material.dart';
import 'package:projetagro/models/product.dart';

class CartItem extends StatelessWidget {
  final Product cartItem;
  final VoidCallback onRemove; // ✅ Callback rehefa manindry ilay delete

  const CartItem({
    super.key,
    required this.cartItem,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              cartItem.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Infos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${cartItem.price.toStringAsFixed(2)} Ar / ${cartItem.unit}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // ✅ Bouton supprimer
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline),
            tooltip: "Supprimer",
          )
        ],
      ),
    );
  }
}
