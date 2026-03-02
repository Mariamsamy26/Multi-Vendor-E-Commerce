import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:provider/provider.dart';
import '../../../providers/product_provider.dart';
import '../widget/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final items = provider.cart;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigation().goToScreen(context, '/home'),
            ),
            title: const Text('Shopping Cart',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  Navigation().goToScreen(context, '/wishlist');
                },
              ),
            ],
          ),
          body: items.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CartItem(product: items[index]);
                  },
                ),
        );
      },
    );
  }
}
