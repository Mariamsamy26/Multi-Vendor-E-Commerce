import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/explore_category_card.dart';
import '../widget/explore_collection_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          'categories'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'search_categories_hint'.tr(),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'main_departments'.tr().toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'view_all'.tr(),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Grid for Main Departments
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 1.1,
              children: [
                ExploreCategoryCard(
                  title: 'electronics'.tr(),
                  subtitle: 'items_count'.tr(args: ['1.2k+']),
                  color: Colors.black87,
                ),
                ExploreCategoryCard(
                  title: 'fashion'.tr(),
                  subtitle: 'items_count'.tr(args: ['4.3k+']),
                  color: Colors.brown[300]!,
                ),
                ExploreCategoryCard(
                  title: 'home_living'.tr(),
                  subtitle: 'items_count'.tr(args: ['2.8k+']),
                  color: Colors.grey[400]!,
                ),
                ExploreCategoryCard(
                  title: 'beauty'.tr(),
                  subtitle: 'items_count'.tr(args: ['950']),
                  color: Colors.pink[200]!,
                ),
                ExploreCategoryCard(
                  title: 'sports'.tr(),
                  subtitle: 'items_count'.tr(args: ['1.5k+']),
                  color: Colors.green[300]!,
                ),
                ExploreCategoryCard(
                  title: 'toys_games'.tr(),
                  subtitle: 'items_count'.tr(args: ['600+']),
                  color: Colors.teal[300]!,
                ),
              ],
            ),

            SizedBox(height: 32.h),
            Text(
              'popular_collections'.tr().toUpperCase(),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),

            ExploreCollectionCard(
              icon: Icons.flash_on,
              title: 'flash_sale'.tr(),
              subtitle: 'flash_sale_subtitle'.tr(),
              iconColor: Colors.blue,
            ),
            ExploreCollectionCard(
              icon: Icons.eco,
              title: 'eco_friendly'.tr(),
              subtitle: 'eco_friendly_subtitle'.tr(),
              iconColor: Colors.green,
            ),
            ExploreCollectionCard(
              icon: Icons.new_releases,
              title: 'new_arrivals'.tr(),
              subtitle: 'new_arrivals_subtitle'.tr(),
              iconColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
