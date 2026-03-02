import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/explore_filter_chip.dart';
import '../widget/explore_product_list_item.dart';
import '../../../../dammy/providers/product_provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Marketplace',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigation().goToScreen(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products, brands...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // Filters Route Simulated
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ExploreFilterChip(
                  label: 'Filters',
                  icon: Icons.tune,
                  isSelected: true,
                ),
                ExploreFilterChip(
                  label: 'Price',
                  icon: Icons.keyboard_arrow_down,
                  isSelected: false,
                ),
                ExploreFilterChip(
                  label: 'Rating',
                  icon: Icons.keyboard_arrow_down,
                  isSelected: false,
                ),
                ExploreFilterChip(
                  label: 'Brand',
                  icon: Icons.keyboard_arrow_down,
                  isSelected: false,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Products List
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, _) {
                final products = provider.products;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ExploreProductListItem(product: products[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
