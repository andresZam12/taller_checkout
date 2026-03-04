import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../database/database_helper.dart';
import 'payment_confirm_screen.dart';

class PaymentDataScreen extends StatefulWidget {
  final double total;

  const PaymentDataScreen({super.key, required this.total});

  @override
  State<PaymentDataScreen> createState() => _PaymentDataScreenState();
}

class _PaymentDataScreenState extends State<PaymentDataScreen> {
  final cardNumberController = TextEditingController();
  final holderController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  bool saveCard = true;
  int selectedMethod = 1; // 0 PayPal, 1 Credit, 2 Wallet

  void proceed() async {
    if (saveCard) {
      final card = CardModel(
        cardNumber: cardNumberController.text,
        cardHolder: holderController.text,
        expiryDate: expiryController.text,
        cvv: cvvController.text,
      );

      await DatabaseHelper.instance.insertCard(card);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentConfirmScreen(
          total: widget.total,
          holderName: holderController.text,
          cardNumber: cardNumberController.text,
        ),
      ),
    );
  }

  Widget paymentMethodButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMethod = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selectedMethod == index
                ? Colors.blue
                : Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selectedMethod == index
                    ? Colors.white
                    : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Payment data")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "\$${widget.total}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),

            const Text("Payment Method"),
            const SizedBox(height: 10),
            Row(
              children: [
                paymentMethodButton("PayPal", 0),
                const SizedBox(width: 10),
                paymentMethodButton("Credit", 1),
                const SizedBox(width: 10),
                paymentMethodButton("Wallet", 2),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: cardNumberController,
              decoration: const InputDecoration(
                labelText: "Card number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiryController,
                    decoration: const InputDecoration(
                      labelText: "Valid until",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: cvvController,
                    decoration: const InputDecoration(
                      labelText: "CVV",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            TextField(
              controller: holderController,
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
              onPressed: proceed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Proceed to confirm"),
            ),
          ],
        ),
      ),
    );
  }
}