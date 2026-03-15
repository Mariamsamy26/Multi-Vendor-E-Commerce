import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/dammy/providers/profile_provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import '../widget/profile_address_card.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'saved_addresses'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final addresses = profileProvider.profile?.addresses ?? [];

          if (addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.location_off_outlined, size: 64.w, color: Colors.grey),
                   SizedBox(height: 16.h),
                   Text('no_addresses_yet'.tr(), style: TextStyle(color: Colors.grey, fontSize: 16.sp)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(24.w),
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Stack(
                  children: [
                    ProfileAddressCard(
                      address: address,
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit_outlined, size: 20.w, color: AppColors.primary),
                            onPressed: () {
                              Navigation().goToScreen(context, '/add-edit-address', extra: address);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline, size: 20.w, color: Colors.red),
                            onPressed: () {
                              _showDeleteDialog(context, profileProvider, address.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigation().goToScreen(context, '/add-edit-address');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ProfileProvider provider, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('delete_address'.tr()),
        content: Text('delete_address_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              provider.removeAddress(id);
              Navigator.pop(context);
            },
            child: Text('delete'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
