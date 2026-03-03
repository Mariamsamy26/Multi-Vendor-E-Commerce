import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';

class CartTotalBar extends StatelessWidget {
  final List<dynamic> items;

  const CartTotalBar({required this.items});

  @override
  Widget build(BuildContext context) {
    final subtotal =
        items.fold<double>(0, (sum, item) => sum + item.price);

    const delivery = 10.0;
    final total = subtotal + delivery;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _row('Subtotal', subtotal),
            const SizedBox(height: 6),
            _row('Delivery', delivery),
            const Divider(height: 20),
            _row('Total', total, isBold: true),
            const SizedBox(height: 12),

            /// Checkout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () =>
                    Navigation().goToScreen(context, '/checkout'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Checkout  \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, double value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}