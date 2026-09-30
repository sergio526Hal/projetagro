import 'package:flutter/material.dart';
import 'package:projetagro/data/services.dart';
import 'package:projetagro/pages/orders_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children:  [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 15),
            child: CircleAvatar(

              child: Image.asset(
                  'assets/sary.jpg',

              ),

            ),
          ),
           Center(
              child:  Text(
                  "Maminomena",
                style: Theme.of(context).textTheme.titleMedium,
              ),
          ),
          Center(
            child:  Text(
              "smaminomena@gmail.com",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 25,),
           ListTile(
               title: const Text("Ma commande"),
             leading: const Icon(Icons.shopping_bag),
             onTap: () {
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => const OrdersPage()
                     ));
             },
           ),
          ListTile(
            title: const Text("A propos "),
            leading: const Icon(Icons.info_sharp),
            onTap: () { },
          ),
          ListTile(
            title: const Text("Deconnecter"),
            leading: const Icon(Icons.logout),
            onTap: () { },
          ),
        ],
      ),
    );
  }
}
