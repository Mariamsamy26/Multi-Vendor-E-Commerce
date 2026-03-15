import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSellerItem extends StatelessWidget {
  final String name;
  final String imageIndex;
  final Color color;

  const HomeSellerItem({
    super.key,
    required this.name,
    required this.imageIndex,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0.w),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: color,
            child: Icon(Icons.person, color: Colors.white, size: 30.w),
          ),
          SizedBox(height: 8.h),
          Text(name, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
