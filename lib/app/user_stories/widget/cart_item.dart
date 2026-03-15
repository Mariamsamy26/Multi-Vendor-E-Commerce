import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../dammy/models/product.dart';
import '../../../dammy/providers/product_provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class CartItem extends StatelessWidget {
  final Product product;

  const CartItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const _CartImage(),
          SizedBox(width: 16.w),
          Expanded(child: _CartDetails(product: product)),
        ],
      ),
    );
  }
}

class _CartImage extends StatelessWidget {
  const _CartImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(Icons.image, color: Colors.grey, size: 24.w),
    );
  }
}

class _CartDetails extends StatelessWidget {
  final Product product;

  const _CartDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => provider.removeFromCart(product),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
