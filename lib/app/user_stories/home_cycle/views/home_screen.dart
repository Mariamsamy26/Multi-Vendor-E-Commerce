import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/home_category_item.dart';
import '../widget/home_seller_item.dart';
import '../widget/home_product_card.dart';
import '../../../../dammy/providers/product_provider.dart'; 
import '../../../../dammy/date_dammy.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.storefront, color: Colors.white, size: 20),
          ),
        ),
        title: const Text(
          'SwiftMarket',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              GoRouter.of(context).push('/wishlist');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Search Bar
            TextField(
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
            const SizedBox(height: 24),

            // Categories Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),

            // Categories List
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeCategoryItem(
                  icon: Icons.devices,
                  label: 'Electronics',
                  bgColor: Color(0xFFE3F2FD), // Colors.blue[50]
                  iconColor: Colors.blue,
                ),
                HomeCategoryItem(
                  icon: Icons.checkroom,
                  label: 'Fashion',
                  bgColor: Color(0xFFFCE4EC), // Colors.pink[50]
                  iconColor: Colors.pink,
                ),
                HomeCategoryItem(
                  icon: Icons.chair_outlined,
                  label: 'Home',
                  bgColor: Color(0xFFFFF3E0), // Colors.orange[50]
                  iconColor: Colors.orange,
                ),
                HomeCategoryItem(
                  icon: Icons.face_retouching_natural,
                  label: 'Beauty',
                  bgColor: Color(0xFFF3E5F5), // Colors.purple[50]
                  iconColor: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Popular Sellers Header
            const Text(
              'Popular Sellers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Sellers List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HomeSellerItem(
                    name: 'Tech Nova',
                    imageIndex: '1',
                    color: Colors.grey[300]!,
                  ),
                  HomeSellerItem(
                    name: 'StyleMe',
                    imageIndex: '2',
                    color: Colors.grey[400]!,
                  ),
                  HomeSellerItem(
                    name: 'Artisans',
                    imageIndex: '3',
                    color: Colors.grey[300]!,
                  ),
                  HomeSellerItem(
                    name: 'FitLife',
                    imageIndex: '4',
                    color: Colors.grey[400]!,
                  ),
                  HomeSellerItem(
                    name: 'CozyHm',
                    imageIndex: '5',
                    color: Colors.grey[300]!,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Featured Products Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
            ),

            // Products Grid - using DummyData directly (no provider required)
            Builder(
              builder: (context) {
                final products = DummyData.products;

                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  children: products
                      .map((p) => HomeProductCard(product: p))
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
