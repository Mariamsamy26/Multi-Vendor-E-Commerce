import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/wishlist_item.dart';
import '../../../../dammy/providers/product_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final wishlist = provider.wishlist;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'wishlist'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              actions: [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  tooltip: 'clear_all'.tr(),
                  onPressed: () {
                    provider.clearWishlist();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('wishlist_cleared'.tr()),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
              bottom: TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'all_items'.tr(args: [wishlist.length.toString()])),
                  Tab(text: 'collections'.tr()),
                ],
              ),
            ),
            body: ListView.builder(
              padding: EdgeInsets.all(16.w),
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
