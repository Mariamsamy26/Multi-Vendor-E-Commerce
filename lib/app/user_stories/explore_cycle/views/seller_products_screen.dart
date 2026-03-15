import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import 'package:multi_vendor_e_commerce/dammy/providers/product_provider.dart';
import '../../home_cycle/widget/home_product_card.dart';

class SellerProductsScreen extends StatefulWidget {
  final String sellerName;

  const SellerProductsScreen({super.key, required this.sellerName});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheSellerImages();
  }

  void _precacheSellerImages() {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final sellerProducts = provider.products
        .where(
          (product) =>
              product.vendor.toLowerCase() == widget.sellerName.toLowerCase(),
        )
        .toList();
    for (var prod in sellerProducts) {
      if (prod.imageUrl.isNotEmpty) {
        precacheImage(CachedNetworkImageProvider(prod.imageUrl), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sellerName = widget.sellerName;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          sellerName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('filter_feature_coming_soon'.tr()),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => GoRouter.of(context).push('/cart'),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          // Filter products by vendor/seller
          final sellerProducts = provider.products
              .where(
                (product) =>
                    product.vendor.toLowerCase() == sellerName.toLowerCase(),
              )
              .toList();

          if (sellerProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store_outlined,
                    size: 80.w,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'no_products_available'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'from_seller'.tr(args: [sellerName]),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seller Header Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.1),
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: Icon(
                          Icons.store,
                          size: 40.w,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sellerName,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'products_count'.tr(args: [sellerProducts.length.toString()]),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 14.w,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'verified_seller'.tr(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'search_seller_products_hint'.tr(args: [sellerName]),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
                SizedBox(height: 24.h),

                // Products Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sellerProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return HomeProductCard(product: sellerProducts[index]);
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
