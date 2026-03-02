import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class OrderListItem extends StatelessWidget {
  final int index;

  const OrderListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isDelivered = index % 2 == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)), // Colors.grey[200]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDelivered
                      ? const Color(0xFFE8F5E9)
                      : const Color(
                          0xFFE3F2FD,
                        ), // Colors.green[50] / Colors.blue[50]
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      isDelivered ? Icons.check_circle : Icons.local_shipping,
                      color: isDelivered ? Colors.green : Colors.blue,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isDelivered ? 'Delivered' : 'Shipped',
                      style: TextStyle(
                        color: isDelivered ? Colors.green : Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Oct 12, 2023',
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 12,
                ), // Colors.grey[500]
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Order #ORD-892$index',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5), // Colors.grey[100]
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nike Air Max Pro Gen-2',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Color: Red | Size: 10',
                      style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 12,
                      ), // Colors.grey[500]
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '\$120.00',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Rate Product'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Buy Again'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
