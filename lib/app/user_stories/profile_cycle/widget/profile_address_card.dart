import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class ProfileAddressCard extends StatelessWidget {
  final String type;
  final String address;
  final bool isDefault;

  const ProfileAddressCard({
    super.key,
    required this.type,
    required this.address,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEEEEEE)), // Colors.grey[200]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                type == 'Home' ? Icons.home_outlined : Icons.work_outline,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              if (isDefault)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'DEFAULT',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            address,
            style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50.w, 30.h),
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  'EDIT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50.w, 30.h),
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  'REMOVE',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
