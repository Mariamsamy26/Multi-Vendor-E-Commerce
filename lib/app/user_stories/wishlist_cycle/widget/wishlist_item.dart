import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../../../../dammy/models/product.dart';
import '../../../../dammy/providers/product_provider.dart';

class WishlistItem extends StatelessWidget {
  final Product product;

  const WishlistItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>(); 
    final bool inStock = product.inStock;

    return GestureDetector( 
      onTap: () {
        Navigation().goToScreen(context, '/product-details', extra: product);
      },
      child: Container(
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
            // Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            ),

            const SizedBox(width: 16),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
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
                      const Icon(Icons.more_vert,
                          color: Colors.grey, size: 20),
                    ],
                  ),

                  /// Vendor
                  Text(
                    product.vendor,
                    style: const TextStyle(
                      color: Color(0xFF9E9E9E),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Stock
                  Text(
                    inStock ? 'IN STOCK' : 'OUT OF STOCK',
                    style: TextStyle(
                      color: inStock ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Price
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (inStock && product.originalPrice != null)
                        Text(
                          '\$${product.originalPrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Color(0xFFBDBDBD),
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Buttons
                  Row(
                    children: [
                      /// Remove from wishlist
                      OutlinedButton.icon(
                        onPressed: () {
                          final removed = provider.removeFromWishlist(product);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                removed
                                    ? 'Removed from wishlist'
                                    : 'Something went wrong',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outline, size: 16),
                        label: const Text('Remove'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      /// Add to cart
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: inStock
                              ? () {
                                  provider.addToCart(product);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text('Added to cart'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              : null,
                          icon: Icon(
                            inStock
                                ? Icons.shopping_cart_outlined // ✅ better icon
                                : Icons.notifications_none,
                            size: 16,
                          ),
                          label: Text(
                            inStock ? 'Add to Cart' : 'Notify Me',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}