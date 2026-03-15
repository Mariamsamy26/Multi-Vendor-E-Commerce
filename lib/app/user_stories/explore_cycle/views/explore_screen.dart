import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/explore_filter_chip.dart';
import '../widget/explore_product_list_item.dart';
import '../../../../dammy/providers/product_provider.dart';
import '../../../../dammy/models/product.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // state used for filtering/sorting
  final Set<String> _selectedCategories = {};
  final Set<String> _selectedVendors = {};
  bool _priceAscending = true;

  // search
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final text = _searchController.text.trim();
      if (text != _searchQuery) {
        setState(() {
          _searchQuery = text;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _applyFilterAndSort(List<Product> products) {
    var list = products;

    // apply text search if provided
    if (_searchQuery.isNotEmpty) {
      list = list
          .where(
            (p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    if (_selectedCategories.isNotEmpty) {
      list = list
          .where((p) => _selectedCategories.contains(p.category))
          .toList();
    }
    if (_selectedVendors.isNotEmpty) {
      list = list.where((p) => _selectedVendors.contains(p.vendor)).toList();
    }

    list.sort((a, b) {
      if (_priceAscending) {
        return a.price.compareTo(b.price);
      } else {
        return b.price.compareTo(a.price);
      }
    });
    return list;
  }

  void _showPriceSortDialog() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('low_to_high'.tr()),
              leading: Radio<bool>(
                value: true,
                groupValue: _priceAscending,
                onChanged: (v) {
                  setState(() {
                    _priceAscending = true;
                  });
                  Navigator.of(ctx).pop();
                },
              ),
            ),
            ListTile(
              title: Text('high_to_low'.tr()),
              leading: Radio<bool>(
                value: false,
                groupValue: _priceAscending,
                onChanged: (v) {
                  setState(() {
                    _priceAscending = false;
                  });
                  Navigator.of(ctx).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCategoryFilter(List<Product> products) {
    final List<String> categories = products
        .map((p) => p.category)
        .toSet()
        .toList();
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx2, setState2) {
            final items = categories
                .map<Widget>(
                  (cat) => CheckboxListTile(
                    title: Text(cat),
                    value: _selectedCategories.contains(cat),
                    onChanged: (v) {
                      setState2(() {
                        if (v == true) {
                          _selectedCategories.add(cat);
                        } else {
                          _selectedCategories.remove(cat);
                        }
                      });
                    },
                  ),
                )
                .toList();
            items.add(
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('done'.tr()),
                ),
              ),
            );
            return Column(mainAxisSize: MainAxisSize.min, children: items);
          },
        );
      },
    ).whenComplete(() => setState(() {}));
  }

  void _showVendorFilter(List<Product> products) {
    final List<String> vendors = products.map((p) => p.vendor).toSet().toList();
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx2, setState2) {
            final items = vendors
                .map<Widget>(
                  (vendor) => CheckboxListTile(
                    title: Text(vendor),
                    value: _selectedVendors.contains(vendor),
                    onChanged: (v) {
                      setState2(() {
                        if (v == true) {
                          _selectedVendors.add(vendor);
                        } else {
                          _selectedVendors.remove(vendor);
                        }
                      });
                    },
                  ),
                )
                .toList();
            items.add(
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('done'.tr()),
                ),
              ),
            );
            return Column(mainAxisSize: MainAxisSize.min, children: items);
          },
        );
      },
    ).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'explore_marketplace'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigation().goToScreen(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'search_hint'.tr(),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          // listener will update state
                        },
                        child: const Icon(Icons.clear, color: Colors.grey),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),

          // Filter / sort chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showCategoryFilter(
                      Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      ).products,
                    );
                  },
                  child: ExploreFilterChip(
                    label: 'filters'.tr(),
                    icon: Icons.tune,
                    isSelected: _selectedCategories.isNotEmpty,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showPriceSortDialog(),
                  child: ExploreFilterChip(
                    label: 'price'.tr(),
                    icon: Icons.keyboard_arrow_down,
                    isSelected: true, // always allow sort
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // rating sort not available yet; simply toggle between asc/desc
                    _showPriceSortDialog();
                  },
                  child: ExploreFilterChip(
                    label: 'rating'.tr(),
                    icon: Icons.keyboard_arrow_down,
                    isSelected: false,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showVendorFilter(
                      Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      ).products,
                    );
                  },
                  child: ExploreFilterChip(
                    label: 'brand'.tr(),
                    icon: Icons.keyboard_arrow_down,
                    isSelected: _selectedVendors.isNotEmpty,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Products List
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, _) {
                // ensure default filter includes everything on first build
                if (_selectedCategories.isEmpty &&
                    provider.products.isNotEmpty) {
                  // add all categories so that "Filters" chip appears active
                  _selectedCategories.addAll(
                    provider.products.map((p) => p.category).toSet(),
                  );
                }
                if (_selectedVendors.isEmpty && provider.products.isNotEmpty) {
                  _selectedVendors.addAll(
                    provider.products.map((p) => p.vendor).toSet(),
                  );
                }

                final products = _applyFilterAndSort(provider.products);
                if (products.isEmpty) {
                  return Center(child: Text('no_products_match'.tr()));
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ExploreProductListItem(product: products[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
