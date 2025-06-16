import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_subject_card.dart';
import 'package:flutter/material.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: CourseSubjectCard(subjectName: 'iuhy76t5resdxc v', onPressed: () {  }, subjectImage: 'assets/image/course1.png',),
          )
          // CourseCard(title: "dtfyg", subtitle: "ctfyvgu", icon: Icons.add_ic_call_outlined, Iconbgcolor: Colors.black26),
          
        ],
      ) ,
    );
  }
}