import 'package:flutter/material.dart';

class CoursesList extends StatelessWidget {
  final String imagePath;
  final double rating;

  const CoursesList({
    super.key,
    required this.imagePath,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 120,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              5,
              (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
            ),
            const SizedBox(width: 4),
            Text(
              rating.toString(),
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
