import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';
import '../widget/profile_info_row.dart';
import '../widget/profile_address_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Avatar and Name
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFE5E7EB),
                    child: Icon(Icons.person, size: 60, color: Colors.grey),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.edit, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Alex Johnson',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'alex.johnson@example.com',
              style: TextStyle(color: Colors.grey[600]),
            ),

            const SizedBox(height: 32),

            // Personal Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PERSONAL INFORMATION',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const ProfileInfoRow(
                    icon: Icons.person_outline,
                    label: 'FULL NAME',
                    value: 'Alex Johnson',
                  ),
                  const Divider(),
                  const ProfileInfoRow(
                    icon: Icons.phone_outlined,
                    label: 'PHONE NUMBER',
                    value: '+1 (555) 987-6543',
                  ),
                  const Divider(),
                  const ProfileInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'DATE OF BIRTH',
                    value: 'March 15, 1992',
                  ),

                  const SizedBox(height: 32),

                  // Saved Addresses
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SAVED ADDRESSES',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add New'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  const ProfileAddressCard(
                    type: 'Home',
                    address: '123 Market St. Apt 4B\nSan Francisco, CA 94103',
                    isDefault: true,
                  ),
                  const SizedBox(height: 16),
                  const ProfileAddressCard(
                    type: 'Work',
                    address:
                        '456 Tech Plaza, 5th Floor\nSan Francisco, CA 94105',
                    isDefault: false,
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
