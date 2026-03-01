import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wishlist',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'All Items (12)'),
              Tab(text: 'Collections'),
            ],
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          itemBuilder: (context, index) {
            return _buildWishlistItem(index);
          },
        ),
      ),
    );
  }

  Widget _buildWishlistItem(int index) {
    bool inStock = index % 2 == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text(
                        'Elite Wireless Headphones',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.more_vert, color: Colors.grey, size: 20),
                  ],
                ),
                Text(
                  'TechNova Global',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  inStock ? 'IN STOCK' : 'OUT OF STOCK',
                  style: TextStyle(
                    color: inStock ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      '\$299.00',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (inStock)
                      Text(
                        '\$399.00',
                        style: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // Buttons
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline, size: 16),
                      label: const Text('Remove'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        foregroundColor: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: inStock ? () {} : null,
                        icon: Icon(
                          inStock
                              ? Icons.shopping_cart
                              : Icons.notifications_none,
                          size: 16,
                        ),
                        label: Text(
                          inStock ? 'Add to Cart' : 'Notify Me',
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
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
    );
  }
}
