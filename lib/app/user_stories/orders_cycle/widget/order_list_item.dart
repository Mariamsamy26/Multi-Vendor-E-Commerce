import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
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
      borderRadius: BorderRadius.circular(20.r),
      onTap: () {
        Navigation().goToScreen(context, '/order-details', extra: order);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),

          /// 🔥 modern shadow
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= Product Image =================
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Image.network(
                product.imageUrl,
                width: 60.w,
                height: 65.h,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 14.w),

            /// ================= Info =================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// top row (id + badge)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${'orders'.tr()} #${order.id}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      _statusBadge(order.status),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  /// name
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  /// meta row
                  Text(
                    '${order.products.length} ${'items'.tr()} • '
                    '${order.date.day}/${order.date.month}/${order.date.year}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),

                  SizedBox(height: 6.h),

                  /// price + rate button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${order.total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      if (isDelivered)
                        SizedBox(
                          height: 32.h,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigation().goToScreen(
                                context,
                                '/rate-order',
                                extra: order,
                              );
                            },
                            icon: Icon(Icons.star, size: 16.w),
                            label: Text(
                              "rate".tr(),
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
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
        text = "delivered".tr();
        break;

      case OrderStatus.processing:
        color = Colors.orange;
        icon = Icons.schedule;
        text = "processing".tr();
        break;

      case OrderStatus.cancelled:
        color = Colors.red;
        icon = Icons.cancel;
        text = "cancelled".tr();
        break;

      default:
        color = Colors.blue;
        icon = Icons.local_shipping;
        text = "shipped".tr();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13.w, color: color),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
