import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/dammy/data/orderes_list.dart';
import 'package:multi_vendor_e_commerce/dammy/models/order.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/order_list_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final allOrders = DummyOrders.orders;

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
          title: const Text(
            'Order History',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'All Orders'),
              Tab(text: 'Ongoing'),
              Tab(text: 'Completed'),
              Tab(text: 'cancelled'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your orders...',
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
  }

Widget _buildOrdersList(List<OrderModel> orders) {
  if (orders.isEmpty) {
    return const Center(
      child: Text('No orders found'),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: orders.length,
    itemBuilder: (context, index) {
      return OrderListItem(order: orders[index]);
    },
  );
}

}
