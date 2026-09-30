import 'package:flutter/material.dart';
import 'package:projetagro/data/orders.dart';
import 'package:projetagro/utils/enums/order.dart';
import 'package:projetagro/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = OrderStatus.values.map((e) => e.name).toList();
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "Ma page de commande",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
              tabs: List.generate(tabs.length, (index){
                return Tab(
                  text: tabs[index],
                );
              }),

          ),
        ),
        body: TabBarView(
            children: List.generate(tabs.length, (index){
              final filteredOrders = orders
                  .where((order) => order.status == OrderStatus.values[index])
                  .toList();
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return OrderItem(order: order);
              },
                  separatorBuilder: (context, index) => SizedBox(height: 10,),
                  itemCount: filteredOrders.length
              );
            })

        ),
      ),
    );
  }
}
