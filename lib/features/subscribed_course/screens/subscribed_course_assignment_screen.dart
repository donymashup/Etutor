import 'package:etutor/features/subscribed_course/screens/no_assigments.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseAssignmentScreen extends StatefulWidget {
  const SubscribedCourseAssignmentScreen({super.key});

  @override
  State<SubscribedCourseAssignmentScreen> createState() =>
      _SubscribedCourseAssignmentScreenState();
}

class Assignments {
  String title;
  String subtitle;
  String type;
  void Function() onPressed;

  Assignments(
      {required this.title,
      required this.subtitle,
      required this.type,
      required this.onPressed});
}

class _SubscribedCourseAssignmentScreenState
    extends State<SubscribedCourseAssignmentScreen> {
  List<Assignments> assignments = [
    Assignments(
        title: "Experiment 2",
        subtitle: "Tap to view this video",
        type: "video",
        onPressed: () {}),
    Assignments(
        title: "Chapter 1 Notes",
        subtitle: "Tap to view this notes",
        type: "pdf",
        onPressed: () {}),
    Assignments(
        title: "Figure 7.2",
        subtitle: "Tap to view this image",
        type: "image",
        onPressed: () {}),
    Assignments(
        title: "Sample Tests",
        subtitle: "Tap to attend this test",
        type: "test",
        onPressed: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "Assignments",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: assignments.isEmpty
                    ? NoAssignments()
                    : ListView.builder(
                        itemCount: assignments.length,
                        itemBuilder: (context, index) => CourseCard(
                          className: assignments[index].title,
                          classDescription: assignments[index].subtitle,
                          packageClassId: '1',
                          // type: assignments[index].type,
                          // onPressed: assignments[index].onPressed,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
