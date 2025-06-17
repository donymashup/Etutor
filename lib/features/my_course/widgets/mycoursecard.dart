import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class MyCourseCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double rating;
  final bool isFree;

  const MyCourseCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.isFree,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            if (isFree)
              const Positioned(
                top: 10,
                left: 10,
                child: Banner(
                  message: 'FREE',
                  location: BannerLocation.topStart,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),

        // Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.blackColor,
          ),
        ),

        const SizedBox(height: 4),

        // Rating row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(5, (index) {
                return const Icon(Icons.star, color: Colors.amber, size: 14);
              }),
            ),
            Text(
              rating.toString(),
              style: const TextStyle(
                color: AppColor.blackColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
