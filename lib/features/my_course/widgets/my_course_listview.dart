import 'package:flutter/material.dart';
import 'mycoursecard.dart'; 

class MyCourseListView extends StatelessWidget {
  final List<Map<String, dynamic>> courses;

  const MyCourseListView({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(), 
      shrinkWrap: true,
      itemCount: courses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final course = courses[index];
        return MyCourseCard(
          imgHeight: MediaQuery.of(context).size.width * 0.45,
          title: course['title'],
          imagePath: course['image'],
          rating: course['rating'],
          isFree: course['isFree'],
        );
      },
    );
  }
}
