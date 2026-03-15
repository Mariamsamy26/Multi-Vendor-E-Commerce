import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:multi_vendor_e_commerce/dammy/providers/profile_provider.dart';
import 'package:multi_vendor_e_commerce/dammy/models/profile_model.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import 'package:multi_vendor_e_commerce/services/navigation_helper.dart';
import 'package:uuid/uuid.dart';

class AddEditAddressScreen extends StatefulWidget {
  final AddressModel? address;
  const AddEditAddressScreen({super.key, this.address});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  late TextEditingController _labelController;
  late TextEditingController _addressController;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.address?.label ?? '');
    _addressController = TextEditingController(text: widget.address?.addressDetails ?? '');
    _isDefault = widget.address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'edit_address'.tr() : 'add_new_address'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _labelController,
              decoration: InputDecoration(
                labelText: 'address_label'.tr(),
                hintText: 'e.g. Home, Work',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _addressController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'address_details'.tr(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(height: 16.h),
            SwitchListTile(
              title: Text('set_as_default'.tr()),
              value: _isDefault,
              onChanged: (value) {
                setState(() {
                  _isDefault = value;
                });
              },
              activeColor: AppColors.primary,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_labelController.text.isEmpty || _addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('please_fill_all_fields'.tr())),
                    );
                    return;
                  }

                  final provider = Provider.of<ProfileProvider>(context, listen: false);
                  if (isEditing) {
                    final updated = widget.address!.copyWith(
                      label: _labelController.text,
                      addressDetails: _addressController.text,
                      isDefault: _isDefault,
                    );
                    provider.updateAddress(updated);
                  } else {
                    final newAddress = AddressModel(
                      id: const Uuid().v4(),
                      label: _labelController.text,
                      addressDetails: _addressController.text,
                      isDefault: _isDefault,
                    );
                    provider.addAddress(newAddress);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEditing ? 'address_updated'.tr() : 'address_added'.tr()),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  'save'.tr(),
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
