import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

import 'package:multi_vendor_e_commerce/dammy/models/profile_model.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/dammy/providers/profile_provider.dart';

class ProfileAddressCard extends StatelessWidget {
  final AddressModel address;

  const ProfileAddressCard({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                address.label == 'Home' ? Icons.home_outlined : Icons.work_outline,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                address.label == 'Home'
                    ? 'home'.tr()
                    : (address.label == 'Work' ? 'work'.tr() : address.label),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (address.isDefault)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'default'.tr().toUpperCase(),
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
            address.addressDetails,
            style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigation().goToScreen(context, '/add-edit-address', extra: address);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50.w, 30.h),
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  'edit'.tr().toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _showDeleteDialog(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(50.w, 30.h),
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  'remove'.tr().toUpperCase(),
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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('delete_address'.tr()),
        content: Text('delete_address_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ProfileProvider>(context, listen: false)
                  .removeAddress(address.id);
              Navigator.pop(ctx);
            },
            child: Text('delete'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
