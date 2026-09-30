
import 'package:flutter/material.dart';

class PageBareDeMenus extends StatelessWidget {
  const PageBareDeMenus({super.key});
  void showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Ma Super App',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 MonNom',
      children: [
        Text('Cette application est conçue pour aider les utilisateurs.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => showAbout(context),
          ),
        ],
      ),
      body: Center(child: Text('Bienvenue dans l’application')),
    );
  }

}




