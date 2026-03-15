import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/dammy/providers/profile_provider.dart';
import '../widget/profile_info_row.dart';
import '../widget/profile_address_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        if (profileProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final profile = profileProvider.profile;
        if (profile == null) {
          return Scaffold(
            body: Center(child: Text("error_loading_profile".tr())),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'my_profile'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.language),
                onPressed: () {
                  if (context.locale == const Locale('en')) {
                    context.setLocale(const Locale('ar'));
                  } else {
                    context.setLocale(const Locale('en'));
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24.h),
                // Avatar and Name
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigation().goToScreen(context, '/edit-profile');
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50.r,
                          backgroundColor: const Color(0xFFE5E7EB),
                          backgroundImage: profile.avatarUrl.isNotEmpty
                              ? NetworkImage(profile.avatarUrl)
                              : null,
                          child: profile.avatarUrl.isEmpty
                              ? Icon(
                                  Icons.person,
                                  size: 60.w,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 16.r,
                            backgroundColor: AppColors.primary,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  profile.fullName,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(profile.email, style: TextStyle(color: Colors.grey[600])),

                SizedBox(height: 32.h),

                // Personal Information
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'personal_information'.tr().toUpperCase(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigation().goToScreen(context, '/edit-profile');
                            },
                            child: Text(
                              'edit'.tr(),
                              style: const TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      ProfileInfoRow(
                        icon: Icons.person_outline,
                        label: 'full_name'.tr().toUpperCase(),
                        value: profile.fullName,
                      ),
                      const Divider(),
                      ProfileInfoRow(
                        icon: Icons.phone_outlined,
                        label: 'phone_number'.tr().toUpperCase(),
                        value: profile.phoneNumber,
                      ),
                      const Divider(),
                      ProfileInfoRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'date_of_birth'.tr().toUpperCase(),
                        value: profile.dateOfBirth,
                      ),

                      SizedBox(height: 32.h),

                      // Saved Addresses
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'saved_addresses'.tr().toUpperCase(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add, size: 16.w),
                            label: Text('add_new'.tr()),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      ...profile.addresses.map((address) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.0.h),
                          child: ProfileAddressCard(
                            type: address.label,
                            address: address.addressDetails,
                            isDefault: address.isDefault,
                          ),
                        );
                      }),

                      SizedBox(height: 48.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
