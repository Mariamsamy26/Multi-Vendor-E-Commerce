import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/styles/colors.dart';

class ExploreFilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;

  const ExploreFilterChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (isSelected)
            const Icon(Icons.check, size: 16, color: Colors.white),
          if (isSelected) const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
