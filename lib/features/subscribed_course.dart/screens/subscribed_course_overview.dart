import 'package:etutor/features/subscribed_course.dart/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseOverview extends StatefulWidget {
  const SubscribedCourseOverview({super.key});

  @override
  State<SubscribedCourseOverview> createState() => _SubscribedCourseOverviewState();
}

class _SubscribedCourseOverviewState extends State<SubscribedCourseOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CourseCard(title: "Class 6", subtitle: "Foundation of class 6", icon: Icons.book, Iconbgcolor: Colors.white10,onPressed: (){},),
          )
        ],
      )),
    );
  }
}