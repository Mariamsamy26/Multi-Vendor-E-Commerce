import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../dammy/models/order.dart';
import '../widget/order_details_widgets.dart';
import 'package:multi_vendor_e_commerce/dammy/data/orderes_list.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderModel order;

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(title: Text('order_details'.tr()), elevation: 0),

      /// 🔥 Sticky bottom button
      bottomNavigationBar: OrderReorderButton(order: order),

      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          /// ================= HEADER =================
          OrderCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${'orders'.tr()} #${order.id}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  '${'placed_on'.tr()} ${order.date.day}/${order.date.month}/${order.date.year}',
                  style: const TextStyle(color: Colors.grey),
                ),

                SizedBox(height: 10.h),

                /// ✅ FIXED Cancel Logic
                OrderStatusBadge(
                  status: order.status,
                  onCancel: () {
                    setState(() {
                      /// optional: update dummy list too
                      final index = DummyOrders.orders.indexWhere(
                        (o) => o.id == order.id,
                      );

                      // order.status = OrderStatus.cancelled;

                      if (index != -1) {
                        DummyOrders.orders[index] = order;
                      }
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("order_cancelled_message".tr())),
                    );
                  },
                ),
              ],
            ),
          ),

          /// ================= TRACKING =================
          OrderCard(child: OrderTrackingTimeline(status: order.status)),

          /// ================= ITEMS =================
          OrderCard(
            child: Column(
              children: order.products
                  .map((p) => OrderProductRow(product: p))
                  .toList(),
            ),
          ),

          /// ================= SUMMARY =================
          OrderCard(
            child: Column(
              children: [
                PriceRow('subtotal'.tr(), order.total - 10),
                PriceRow('delivery'.tr(), 10),
                const Divider(),
                PriceRow('total'.tr(), order.total, bold: true),
              ],
            ),
          ),

          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
