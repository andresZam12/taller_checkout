import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/card_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  bool saveCard = true;

  void saveCardData() async {
    final card = CardModel(
      cardNumber: _cardNumberController.text,
      cardHolder: _cardHolderController.text,
      expiryDate: _expiryController.text,
      cvv: _cvvController.text,
    );

    await DatabaseHelper.instance.insertCard(card);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tarjeta guardada en SQLite")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Payment data")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "\$2,280.00",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(
                labelText: "Card number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _expiryController,
              decoration: const InputDecoration(
                labelText: "Valid until",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _cvvController,
              decoration: const InputDecoration(
                labelText: "CVV",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _cardHolderController,
              decoration: const InputDecoration(
                labelText: "Card holder",
                border: OutlineInputBorder(),
              ),
            ),

            SwitchListTile(
              title: const Text("Save card data"),
              value: saveCard,
              onChanged: (value) {
                setState(() {
                  saveCard = value;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (saveCard) {
                  saveCardData();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              child: const Text("Proceed to confirm"),
            )
          ],
        ),
      ),
    );
  }
}