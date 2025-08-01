
import 'package:etutor/features/home/widgets/courses_list.dart';
import 'package:etutor/features/my_course/screens/course_details_screen.dart';
import 'package:flutter/material.dart';

// Reusable CoursesGridWidget that accepts a list
class CoursesGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> courses;
  final double horizontalSpacing;
  final double verticalSpacing;
  final EdgeInsets padding;
  final Function(Map<String, dynamic>)? onCourseTab;

  const CoursesGridWidget({
    Key? key,
    required this.courses,
    this.horizontalSpacing = 12.0,
    this.verticalSpacing = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.onCourseTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Container(
        padding: padding,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school_outlined, size: 60, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text(
                'No courses available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Wrap(
        spacing: horizontalSpacing,
        runSpacing: verticalSpacing,
        children: List.generate(courses.length, (index) {
          final course = courses[index];
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 
                   (padding.left + padding.right + horizontalSpacing)) / 2, 
            child: GestureDetector(
               onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CourseDetailsScreen()),
              );
            },
              child: CoursesList(
                imagePath: course['imagePath'] ?? '',
                title: course['title'] ?? 'No Title',
                rating: course['rating']?.toDouble() ?? 0.0,
               // onTap: () => onCourseTab?.call(course),
              ),
            ),
          );
        }),
      ),
    );
  }
}