import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/dammy/models/order.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel order;

  const OrderListItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final product = order.products.first;
    final isDelivered = order.status == OrderStatus.delivered;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigation().goToScreen(
          context,
          '/order-details',
          extra: order,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          /// 🔥 modern shadow
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// ================= Product Image =================
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                product.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            /// ================= Info =================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// top row (id + badge)
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      _statusBadge(order.status),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// name
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// meta row
                  Text(
                    '${order.products.length} items • '
                    '${order.date.day}/${order.date.month}/${order.date.year}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// price + rate button
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${order.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      if (isDelivered)
                        SizedBox(
                          height: 32,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigation().goToScreen(
                                context,
                                '/rate-order',
                                extra: order,
                              );
                            },
                            icon: const Icon(Icons.star,
                                size: 16),
                            label: const Text(
                              "Rate",
                              style:
                                  TextStyle(fontSize: 12),
                            ),
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primary,
                              padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 10),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                        10),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            /// arrow
            const Icon(Icons.chevron_right,
                color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // Status Badge (multi states)
  // =====================================================

  Widget _statusBadge(OrderStatus status) {
    Color color;
    IconData icon;
    String text;

    switch (status) {
      case OrderStatus.delivered:
        color = Colors.green;
        icon = Icons.check_circle;
        text = "Delivered";
        break;

      case OrderStatus.processing:
        color = Colors.orange;
        icon = Icons.schedule;
        text = "Processing";
        break;

      case OrderStatus.cancelled:
        color = Colors.red;
        icon = Icons.cancel;
        text = "Cancelled";
        break;

      default:
        color = Colors.blue;
        icon = Icons.local_shipping;
        text = "Shipped";
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}