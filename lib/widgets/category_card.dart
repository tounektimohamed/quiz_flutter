import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            category,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}