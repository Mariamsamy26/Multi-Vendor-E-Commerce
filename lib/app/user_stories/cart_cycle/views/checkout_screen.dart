import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../dammy/providers/product_provider.dart';
import '../../../../dammy/models/product.dart';
import '../../../../dammy/data/orderes_list.dart';
import '../../../../dammy/models/order.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int deliveryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final items = provider.cart;

        final subtotal =
            items.fold<double>(0, (s, e) => s + e.price);

        const delivery = 10.0;
        final total = subtotal + delivery;

        if (items.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('Your cart is empty')),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xffF5F6FA),

          appBar: AppBar(
            elevation: 0,
            title: const Text('Checkout'),
          ),

          /// 🔥 Sticky button like design
          bottomNavigationBar: _placeOrderButton(
            total,
            provider,
          ),

          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [

              /// Address
              _card(
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text("Home Address"),
                  subtitle: const Text(
                      "Cairo, Nasr City, Street 12"),
                  trailing: const Icon(Icons.edit),
                ),
              ),

              /// Delivery options
              _card(
                child: Column(
                  children: [
                    _radio("Standard Delivery", 0),
                    _radio("Express Delivery", 1),
                  ],
                ),
              ),

              /// Products
              _card(
                child: Column(
                  children:
                      items.map(_productRow).toList(),
                ),
              ),

              /// Price summary
              _card(
                child: Column(
                  children: [
                    _priceRow("Subtotal", subtotal),
                    _priceRow("Delivery", delivery),
                    const Divider(),
                    _priceRow("Total", total, bold: true),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }

  // =========================
  // Widgets
  // =========================

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _productRow(Product p) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              p.imageUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(p.name)),
          Text("\$${p.price.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _priceRow(String title, double value,
      {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight:
                      bold ? FontWeight.bold : null)),
          Text("\$${value.toStringAsFixed(2)}",
              style: TextStyle(
                  fontWeight:
                      bold ? FontWeight.bold : null)),
        ],
      ),
    );
  }

  Widget _radio(String text, int value) {
    return RadioListTile(
      value: value,
      groupValue: deliveryIndex,
      onChanged: (v) =>
          setState(() => deliveryIndex = v!),
      title: Text(text),
    );
  }

  Widget _placeOrderButton(
      double total, ProductProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            // create a new order from the cart contents
            final newOrder = OrderModel(
              id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
              date: DateTime.now(),
              status: OrderStatus.shipped,
              products: List<Product>.from(provider.cart),
            );
            DummyOrders.orders.insert(0, newOrder); // add to front of list

            // clear cart then jump to home (root screen) clearing history
            provider.clearCart();
            Navigation().goToScreenAndClearAll(context, '/home');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16),
            ),
          ),
          child: Text(
            "Place Order  \$${total.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}