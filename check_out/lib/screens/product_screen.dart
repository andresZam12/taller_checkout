import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'payment_data_screen.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final List<Product> products = [
    Product(name: "Nike Air Max", price: 150),
    Product(name: "Adidas Hoodie", price: 80),
    Product(name: "Apple Watch", price: 300),
    Product(name: "Headphones Sony", price: 120),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PaymentDataScreen(total: product.price),
                    ),
                  );
                },
                child: const Text("Buy"),
              ),
            ),
          );
        },
      ),
    );
  }
}