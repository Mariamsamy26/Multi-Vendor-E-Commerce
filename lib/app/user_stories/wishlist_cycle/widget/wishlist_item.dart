import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.image, color: Colors.grey, size: 24.w),
            ),

            SizedBox(width: 16.w),

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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.more_vert, color: Colors.grey, size: 20.w),
                    ],
                  ),

                  /// Vendor
                  Text(
                    product.vendor,
                    style: TextStyle(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 12.sp,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Stock
                  Text(
                    inStock ? 'IN STOCK' : 'OUT OF STOCK',
                    style: TextStyle(
                      color: inStock ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  /// Price
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      if (inStock && product.originalPrice != null)
                        Text(
                          '\$${product.originalPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: const Color(0xFFBDBDBD),
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  /// Buttons
                  Row(
                    children: [
                      /// Remove from wishlist
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            final removed = provider.removeFromWishlist(
                              product,
                            );

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
                          icon: Icon(Icons.delete_outline, size: 15.w),
                          label: Text(
                            'Remove',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            // padding: EdgeInsets.symmetric(
                            //   horizontal: 12.w,
                            //   vertical: 8.h,
                            // ),
                          ),
                        ),
                      ),

                      SizedBox(width: 8.w),

                      /// Add to cart
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: inStock
                              ? () {
                                  provider.addToCart(product);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Added to cart'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              : null,
                          icon: Icon(
                            inStock
                                ? Icons
                                      .shopping_cart_outlined // ✅ better icon
                                : Icons.notifications_none,
                            size: 15.w,
                          ),
                          label: Text(
                            inStock ? 'Add to Cart' : 'Notify Me',
                            style: TextStyle(fontSize: 12.sp),
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
