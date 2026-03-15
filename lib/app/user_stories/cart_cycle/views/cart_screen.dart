import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor_e_commerce/app/user_stories/cart_cycle/widget/cart_total.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:provider/provider.dart';
import '../../../../dammy/providers/product_provider.dart';
import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        final items = provider.cart;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'shopping_cart'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  Navigation().goToScreen(context, '/wishlist');
                },
              ),
            ],
          ),
          body: items.isEmpty
              ? Center(child: Text('empty_cart'.tr()))
              : Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: ListView.builder(
                        padding: EdgeInsets.all(16.w),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return CartItem(product: items[index]);
                        },
                      ),
                    ),
                    Expanded(flex: 3, child: CartTotalBar(items: items)),
                  ],
                ),
        );
      },
    );
  }
}
