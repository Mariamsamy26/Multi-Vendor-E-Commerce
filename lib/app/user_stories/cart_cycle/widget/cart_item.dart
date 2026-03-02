import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../dammy/models/product.dart';
import '../../../../dammy/providers/product_provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class CartItem extends StatelessWidget {
  final Product product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CartImage(),
          const SizedBox(width: 16),
          Expanded(child: _CartDetails(product: product)),
        ],
      ),
    );
  }
}

class _CartImage extends StatelessWidget {
  const _CartImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }
}

class _CartDetails extends StatelessWidget {
  final Product product;

  const _CartDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => provider.removeFromCart(product),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
