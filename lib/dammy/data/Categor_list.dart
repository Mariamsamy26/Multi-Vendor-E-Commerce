import 'package:flutter/material.dart';
import 'package:multi_vendor_e_commerce/dammy/data/date_dammy.dart';
import 'package:multi_vendor_e_commerce/dammy/models/categories.dart';

class CategoriesList {
  CategoriesList._();

  static List<CategoryModel> get categories {
    final uniqueCategories = DummyData.products
        .map((e) => e.category)
        .toSet()
        .toList();

    return uniqueCategories.map((category) {
      switch (category) {
        case 'Electronics':
          return const CategoryModel(
            icon: Icons.devices,
            label: 'Electronics',
            bgColor: Color(0xFFE3F2FD),
            iconColor: Colors.blue,
          );

        case 'Fashion':
          return const CategoryModel(
            icon: Icons.checkroom,
            label: 'Fashion',
            bgColor: Color(0xFFFCE4EC),
            iconColor: Colors.pink,
          );

        case 'Home':
          return const CategoryModel(
            icon: Icons.chair_outlined,
            label: 'Home',
            bgColor: Color(0xFFFFF3E0),
            iconColor: Colors.orange,
          );

        case 'Beauty':
          return const CategoryModel(
            icon: Icons.face_retouching_natural,
            label: 'Beauty',
            bgColor: Color(0xFFF3E5F5),
            iconColor: Colors.purple,
          );

        default:
          return CategoryModel(
            icon: Icons.category,
            label: category,
            bgColor: Colors.grey.shade200,
            iconColor: Colors.grey.shade700,
          );
      }
    }).toList();
  }
}
