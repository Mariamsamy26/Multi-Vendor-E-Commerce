import 'package:flutter/material.dart';

class CategoryModel {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;

  const CategoryModel({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
  });
}