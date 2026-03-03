import 'package:flutter/material.dart';
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

      appBar: AppBar(
        title: const Text('Order Details'),
        elevation: 0,
      ),

      /// 🔥 Sticky bottom button
      bottomNavigationBar: OrderReorderButton(order: order),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ================= HEADER =================
          OrderCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Placed on ${order.date.day}/${order.date.month}/${order.date.year}',
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 10),

                /// ✅ FIXED Cancel Logic
                OrderStatusBadge(
                  status: order.status,
                  onCancel: () {
                    setState(() {
                    

                      /// optional: update dummy list too
                      final index = DummyOrders.orders
                          .indexWhere((o) => o.id == order.id);

  // order.status = OrderStatus.cancelled;
  
                      if (index != -1) {
                        DummyOrders.orders[index] = order;
                      }
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order cancelled"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          /// ================= TRACKING =================
          OrderCard(
            child: OrderTrackingTimeline(status: order.status),
          ),

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
                PriceRow('Subtotal', order.total - 10),
                PriceRow('Delivery', 10),
                const Divider(),
                PriceRow('Total', order.total, bold: true),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}