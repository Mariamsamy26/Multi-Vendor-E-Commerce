import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/explore_category_card.dart';
import '../widget/explore_collection_card.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for electronics, fashion...',
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'MAIN DEPARTMENTS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(fontSize: 12, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Grid for Main Departments
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                const ExploreCategoryCard(
                  title: 'Electronics',
                  subtitle: '1.2k+ Items',
                  color: Colors.black87,
                ),
                ExploreCategoryCard(
                  title: 'Fashion',
                  subtitle: '4.3k+ Items',
                  color: Colors.brown[300]!,
                ),
                ExploreCategoryCard(
                  title: 'Home & Living',
                  subtitle: '2.8k+ Items',
                  color: Colors.grey[400]!,
                ),
                ExploreCategoryCard(
                  title: 'Beauty',
                  subtitle: '950 Items',
                  color: Colors.pink[200]!,
                ),
                ExploreCategoryCard(
                  title: 'Sports',
                  subtitle: '1.5k+ Items',
                  color: Colors.green[300]!,
                ),
                ExploreCategoryCard(
                  title: 'Toys & Games',
                  subtitle: '600+ Items',
                  color: Colors.teal[300]!,
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Text(
              'POPULAR COLLECTIONS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            const ExploreCollectionCard(
              icon: Icons.flash_on,
              title: 'Flash Sale',
              subtitle: 'Up to 70% off daily deals',
              iconColor: Colors.blue,
            ),
            const ExploreCollectionCard(
              icon: Icons.eco,
              title: 'Eco-Friendly',
              subtitle: 'Sustainable lifestyle choices',
              iconColor: Colors.green,
            ),
            const ExploreCollectionCard(
              icon: Icons.new_releases,
              title: 'New Arrivals',
              subtitle: 'Fresh items added this week',
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
