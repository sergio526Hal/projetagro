import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  final double totalAmount;
  const PaymentPage({super.key, required this.totalAmount});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _phoneController = TextEditingController();
  String _selectedProvider = "MVola";

  Future<void> _processPayment() async {
    final phone = _phoneController.text.trim();
    final amount = widget.totalAmount.toInt();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer votre numéro")),
      );
      return;
    }

    // 🚀 Eto no hifandray amin'ny backend-nao na API sandbox Mvola
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        Uri.parse("https://ton-backend.com/pay"), // SOLOINA amin'ny backend-nao
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "provider": _selectedProvider,
          "phoneNumber": phone,
          "amount": amount,
          "currency": "MGA",
        }),
      );

      Navigator.pop(context); // akatona loading

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Paiement $_selectedProvider réussi ✅")),
        );
        Navigator.pop(context); // miverina any amin'ny CartPage
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur paiement $_selectedProvider ❌")),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur réseau: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paiement Mobile Money")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Montant total: ${widget.totalAmount.toStringAsFixed(2)} Ar",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: "Numéro téléphone",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedProvider,
              items: ["MVola", "Orange Money", "Airtel Money"]
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedProvider = val!),
              decoration: const InputDecoration(
                labelText: "Choisir opérateur",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton.icon(
              onPressed: _processPayment,
              icon: const Icon(Icons.payment),
              label: const Text("Payer maintenant"),
            ),
          ],
        ),
      ),
    );
  }
}
