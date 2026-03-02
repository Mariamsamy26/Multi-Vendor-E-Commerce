import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/product_spec_chip.dart';
import '../../../models/product.dart';
import '../../../providers/product_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product? product;

  const ProductDetailsPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final prod = product ?? provider.products.first;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Header
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[100],
              child: Stack(
                children: [
                  if (prod.imageUrl.isNotEmpty)
                    Positioned.fill(
                      child: Image.network(
                        prod.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (c, o, s) => const Center(
                          child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    const Center(
                      child: Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.black38,
                      ),
                    ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        final added = provider.toggleWishlistStatus(prod);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              added ? 'Added to wishlist' : 'Removed from wishlist',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.8),
                        child: Icon(
                          prod.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: prod.isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PREMIUM AUDIO',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Text(
                            ' 4.9',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            ' (12K reviews)',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Vision Pro Headphones',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '\$299.99',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$349.00',
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Experience audio like never before with the Vision Pro. Featuring industry-leading noise cancellation, spatial audio, and up to 40 hours of battery life. Crafted from premium materials for ultimate comfort during long listening sessions.',
                    style: TextStyle(color: Colors.grey[600], height: 1.5),
                  ),

                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Expanded(
                        child: ProductSpecChip(
                          icon: Icons.battery_charging_full,
                          label: '40h Battery',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ProductSpecChip(
                          icon: Icons.bluetooth,
                          label: 'BT 5.2',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See all'),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              child: Icon(Icons.person, size: 16),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'James Smith',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: List.generate(
                                5,
                                (_) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The sound quality on these is incredible. Best noise cancellation I\'ve ever experienced.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.favorite_border),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  provider.addToCart(prod);
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
