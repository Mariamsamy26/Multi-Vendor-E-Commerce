import 'package:flutter/material.dart';

class HomeSellerItem extends StatelessWidget {
  final String name;
  final String imageIndex;
  final Color color;

  const HomeSellerItem({
    super.key,
    required this.name,
    required this.imageIndex,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
