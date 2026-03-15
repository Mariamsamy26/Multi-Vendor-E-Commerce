import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class ExploreFilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;

  const ExploreFilterChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          if (isSelected) Icon(Icons.check, size: 16.w, color: Colors.white),
          if (isSelected) SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            icon,
            size: 16.w,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
