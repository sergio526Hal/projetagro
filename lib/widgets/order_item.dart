import 'package:flutter/material.dart';
import 'package:projetagro/models/order.dart';
import 'package:projetagro/widgets/order_product.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalPrice = order.products.fold(0.0, (acc, e) => acc + e.price);
    final products = order.products.take(2).toList();
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        side: BorderSide(color:  Colors.grey),
      ),
      elevation: 0.8,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                    "Order: ${order.id}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                ),
                const Spacer(),
                Text('${order.products.length} Items)',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(width: 5),
                Text("\ ${totalPrice.toStringAsFixed(2)} Ar")
              ],
            ),
           const SizedBox(height: 20),
            ...List.generate(products.length, (index){
              return OrderProduct(
                  product: products[index],
                  order: order,
              );
            }),
            if(order.products.length>1)
            const SizedBox(height: 10),
            if(order.products.length>1)
              TextButton.icon(
                onPressed: (){
                  showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      isScrollControlled: true,
                      builder: (context){
                        return Container(
                          height: 10,
                          child: ListView.builder(
                            itemCount: order.products.length,
                              padding: const EdgeInsets.all(14),
                              itemBuilder: (context, index){
                            final product = order.products[index];
                            return OrderProduct(order: order, product: product);
                          }
                          ),
                        );
                      },
                  );
                },
                label: const Text("voir touts"),
                icon: const Icon(Icons.arrow_right),
              ),
          ],
        ),
      ),
    );
  }
}
