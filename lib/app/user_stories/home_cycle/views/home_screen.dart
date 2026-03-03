import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:multi_vendor_e_commerce/dammy/data/Categor_list.dart';
import 'package:multi_vendor_e_commerce/dammy/data/sellers_list.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/home_category_item.dart';
import '../widget/home_seller_item.dart';
import '../widget/home_product_card.dart';
import '../../../../dammy/providers/product_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheProductImages();
  }

  void _precacheProductImages() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    for (var prod in provider.products) {
      if (prod.imageUrl.isNotEmpty) {
        precacheImage(
          CachedNetworkImageProvider(prod.imageUrl),
          context,
        );
      }
    }
  }

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
          // IconButton(
          //   icon: const Icon(Icons.notifications_none),
          //   onPressed: () => GoRouter.of(context).push('/notifications'),
          // ),
          Consumer<ProductProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: Icon(
                  Icons.favorite ,
                  color:  Colors.grey,
                ),
                onPressed: () => GoRouter.of(context).go('/wishlist'),
              );
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
               // Popular Sellers Header
            const Text(
              'Popular Sellers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Sellers List
            SizedBox(
  height: 100,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: SellersList.sellers.length,
    itemBuilder: (context, index) {
      final seller = SellersList.sellers[index];

      return GestureDetector(
        onTap: () => GoRouter.of(context).push(
          '/seller',
          extra: seller.name,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: HomeSellerItem(
            name: seller.name,
            imageIndex: seller.imageIndex,
            color: seller.color,
          ),
        ),
      );
    },
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
            
              ],
            ),

            // Categories List
            SizedBox(
  height: 100,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: CategoriesList.categories.length,
    itemBuilder: (context, index) {
      final category = CategoriesList.categories[index];

      return GestureDetector(
        onTap: () => GoRouter.of(context).push(
          '/category',
          extra: category.label,
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10.0),
          child: HomeCategoryItem(
            icon: category.icon,
            label: category.label,
            bgColor: category.bgColor,
            iconColor: category.iconColor,
          ),
        ),
      );
    },
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
                // IconButton(
                //   icon: const Icon(Icons.filter_list),
                //   onPressed: () => GoRouter.of(context).push('/filter'),
                // ),
              ],
            ),

            // Products Grid - listen to provider for updates
            Consumer<ProductProvider>(
              builder: (context, provider, _) {
                final products = provider.products;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return HomeProductCard(product: products[index]);
                  },
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
