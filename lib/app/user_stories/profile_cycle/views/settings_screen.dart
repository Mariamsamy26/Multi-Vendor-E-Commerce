import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          _buildSettingItem(
            icon: Icons.notifications_none_outlined,
            title: 'notifications'.tr(),
            onTap: () {},
          ),
          const Divider(),
          _buildSettingItem(
            icon: Icons.lock_outline,
            title: 'privacy_policy'.tr(),
            onTap: () {},
          ),
          const Divider(),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'help_center'.tr(),
            onTap: () {},
          ),
          const Divider(),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'about_us'.tr(),
            onTap: () {},
          ),
          SizedBox(height: 32.h),
          TextButton(
            onPressed: () {
              // TODO: Implement logout
            },
            child: Text(
              'logout'.tr(),
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
