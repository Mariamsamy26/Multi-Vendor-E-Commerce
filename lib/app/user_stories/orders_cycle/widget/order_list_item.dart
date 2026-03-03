import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/dammy/models/order.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final product = order.products.first;
    final isDelivered = order.status == OrderStatus.delivered;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Status + Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusBadge(isDelivered),
              Text(
                '${order.date.day}/${order.date.month}/${order.date.year}',
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Order ID
          Text(
            'Order #${order.id}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 12),

          /// Product
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order.products.length} item(s)',
                      style: const TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${order.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(bool delivered) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: delivered
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            delivered ? Icons.check_circle : Icons.local_shipping,
            size: 14,
            color: delivered ? Colors.green : Colors.blue,
          ),
          const SizedBox(width: 4),
          Text(
            delivered ? 'Delivered' : 'Shipped',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: delivered ? Colors.green : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}