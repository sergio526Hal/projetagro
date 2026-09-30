import 'package:flutter/material.dart';
import 'package:projetagro/pages/home_page.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Image.asset("assets/ispm.jpeg",
                width: 1000,
              ),
              Spacer(),
              Text(
                "Bienvenue chez Agro-Business",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.green.shade900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text("Recevez vos produits agricoles sans bouger de chez vous.Qeulques clics suffisent pour avoir vos produits!."),
              ),
              FilledButton.tonalIcon(
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                },
                icon: const Icon(Icons.login),
                label: const Text("Continuer           "),
              ),
            ],
          ),
        ),),
    );
  }
}
