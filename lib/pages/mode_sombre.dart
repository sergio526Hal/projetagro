
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mode Sombre',
      theme: ThemeData.light(), // Thème clair
      darkTheme: ThemeData.dark(), // Thème sombre
      themeMode: ThemeMode.system, // Change selon le système (ou utilise ThemeMode.dark pour forcer)
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mode Sombre")),
      body: Center(child: Text("Bonjour en mode clair ou sombre")),
    );
  }
}



