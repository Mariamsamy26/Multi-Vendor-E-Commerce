import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor_e_commerce/dammy/models/order.dart';
import 'package:multi_vendor_e_commerce/dammy/providers/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/order_list_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        if (orderProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final allOrders = orderProvider.orders;

        final ongoing = allOrders
            .where((o) => o.status == OrderStatus.shipped)
            .toList();

        final completed = allOrders
            .where((o) => o.status == OrderStatus.delivered)
            .toList();

        final cancelled = allOrders
            .where((o) => o.status == OrderStatus.cancelled)
            .toList();

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'order_history'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              bottom: TabBar(
                isScrollable: true,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'all_orders'.tr()),
                  Tab(text: 'ongoing'.tr()),
                  Tab(text: 'completed'.tr()),
                  Tab(text: 'cancelled'.tr()),
                ],
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'search_orders_hint'.tr(),
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
                ),

                Expanded(
                  child: TabBarView(
                    children: [
                      _buildOrdersList(allOrders),
                      _buildOrdersList(ongoing),
                      _buildOrdersList(completed),
                      _buildOrdersList(cancelled),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrdersList(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return Center(child: Text('no_orders_found_message'.tr()));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderListItem(order: orders[index]);
      },
    );
  }
}
