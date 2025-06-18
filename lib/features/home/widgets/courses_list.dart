import 'package:flutter/material.dart';

class CoursesList extends StatelessWidget {
  final String imagePath;
  final double rating;
  final String title; 

  const CoursesList({
    super.key,
    required this.imagePath,
    required this.rating,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      // height: ,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Image
          Container(
            height: MediaQuery.of(context).size.width * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Course Title
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 5),

          // Stars + Rating Row
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
                  ),
                ),
                Text(
                  rating.toString(),
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
