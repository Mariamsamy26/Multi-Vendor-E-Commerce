import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

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
                  _buildInfoRow(
                    Icons.person_outline,
                    'FULL NAME',
                    'Alex Johnson',
                  ),
                  const Divider(),
                  _buildInfoRow(
                    Icons.phone_outlined,
                    'PHONE NUMBER',
                    '+1 (555) 987-6543',
                  ),
                  const Divider(),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    'DATE OF BIRTH',
                    'March 15, 1992',
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

                  _buildAddressCard(
                    'Home',
                    '123 Market St. Apt 4B\nSan Francisco, CA 94103',
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildAddressCard(
                    'Work',
                    '456 Tech Plaza, 5th Floor\nSan Francisco, CA 94105',
                    false,
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(String type, String address, bool isDefault) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                type == 'Home' ? Icons.home_outlined : Icons.work_outline,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              if (isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'DEFAULT',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            address,
            style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  'EDIT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  'REMOVE',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
