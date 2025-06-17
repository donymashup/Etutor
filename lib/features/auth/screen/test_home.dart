import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_subject_card.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/subject_overview_card.dart';
import 'package:flutter/material.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.whiteColor,
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child:
              SubjectOverviewCard(title: "title", description: "description", subjectImage: "assets/images/subname1.jpg")
            )
            
          ],
        ) ,
      ),
    );
  }
}