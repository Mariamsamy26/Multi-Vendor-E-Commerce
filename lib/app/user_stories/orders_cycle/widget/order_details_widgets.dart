import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../dammy/models/order.dart';
import '../../../../dammy/models/product.dart';
import '../../../../dammy/data/orderes_list.dart';
import '../../../../dammy/providers/product_provider.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';

/// Reusable card container with shadow and border radius
class OrderCard extends StatelessWidget {
  final Widget child;

  const OrderCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.r,
            color: Colors.black12,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Product row with image, name, and price
class OrderProductRow extends StatelessWidget {
  final Product product;

  const OrderProductRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              product.imageUrl,
              width: 50.w,
              height: 50.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(product.name, style: TextStyle(fontSize: 14.sp)),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

/// Tracking timeline showing order progress
class OrderTrackingTimeline extends StatelessWidget {
  final OrderStatus status;

  const OrderTrackingTimeline({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    int step = switch (status) {
      OrderStatus.processing => 0,
      OrderStatus.shipped => 1,
      OrderStatus.delivered => 2,
      _ => 0,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tracking',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TrackingStep('Processing', step >= 0),
            TrackingLine(step >= 1),
            TrackingStep('Shipped', step >= 1),
            TrackingLine(step >= 2),
            TrackingStep('Delivered', step >= 2),
          ],
        ),
      ],
    );
  }
}

/// Single step circle in tracking timeline
class TrackingStep extends StatelessWidget {
  final String title;
  final bool done;

  const TrackingStep(this.title, this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 10.r,
          backgroundColor: done ? Colors.green : Colors.grey.shade300,
          child: done
              ? Icon(Icons.check, size: 12.w, color: Colors.white)
              : null,
        ),
        SizedBox(height: 4.h),
        Text(title, style: TextStyle(fontSize: 11.sp)),
      ],
    );
  }
}

/// Connecting line between tracking steps
class TrackingLine extends StatelessWidget {
  final bool done;

  const TrackingLine(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2.h,
        color: done ? Colors.green : Colors.grey.shade300,
      ),
    );
  }
}

/// Price row (label and value)
class PriceRow extends StatelessWidget {
  final String title;
  final double value;
  final bool bold;

  const PriceRow(this.title, this.value, {super.key, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;
  final VoidCallback? onCancel;

  const OrderStatusBadge({super.key, required this.status, this.onCancel});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color textColor;
    String label;

    switch (status) {
      case OrderStatus.delivered:
        bg = Colors.green.withValues(alpha: 0.12);
        textColor = Colors.green;
        label = "Delivered";
        break;

      case OrderStatus.shipped:
        bg = Colors.blue.withValues(alpha: 0.12);
        textColor = Colors.blue;
        label = "Shipped";
        break;

      case OrderStatus.cancelled:
        bg = Colors.red.withValues(alpha: 0.12);
        textColor = Colors.red;
        label = "Cancelled";
        break;

      default:
        bg = Colors.grey.withValues(alpha: 0.12);
        textColor = Colors.grey;
        label = "Processing";
    }

    return Row(
      children: [
        /// Status Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
        const Spacer(),
        // /// Cancel Button (only if not delivered/cancelled)
        // if (!isDelivered && !isCancelled) ...[
        //   const SizedBox(width: 10),
        //   GestureDetector(
        //     onTap: onCancel,
        //     child: Container(
        //       padding: const EdgeInsets.symmetric(
        //           horizontal: 10, vertical: 6),
        //       decoration: BoxDecoration(
        //         color: Colors.red.withOpacity(.12),
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       child: const Text(
        //         "Cancel",
        //         style: TextStyle(
        //           color: Colors.red,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ],
    );
  }
}

/// Re-order button with full logic
class OrderReorderButton extends StatelessWidget {
  final OrderModel order;

  const OrderReorderButton({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        height: 55.h,
        child: ElevatedButton(
          onPressed: () {
            final provider = Provider.of<ProductProvider>(
              context,
              listen: false,
            );

            provider.reorder(order);

            final newOrder = OrderModel(
              id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
              date: DateTime.now(),
              status: OrderStatus.shipped,
              products: List.from(order.products),
            );

            DummyOrders.orders.insert(0, newOrder);

            Navigation().goToScreenAndClearAll(context, '/cart');
          },
          child: Text(
            "Re-Order",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
