import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/wishlist_item.dart';
import '../../../providers/product_provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final wishlist = provider.wishlist;
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
              bottom: TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'All Items (${wishlist.length})'),
                  const Tab(text: 'Collections'),
                ],
              ),
            ),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                return WishlistItem(product: wishlist[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
