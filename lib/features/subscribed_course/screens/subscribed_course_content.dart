import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_assignment_screen.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseContent extends StatefulWidget {
  const SubscribedCourseContent({super.key});

  @override
  State<SubscribedCourseContent> createState() =>
      _SubscribedCourseContentState();
}

class CourseContent {
  String title;
  String subtitle;
  String type;
  void Function() onPressed;

  CourseContent(
      {required this.title,
      required this.subtitle,
      required this.type,
      required this.onPressed});
}

class _SubscribedCourseContentState extends State<SubscribedCourseContent> {
  late List<CourseContent> coursecontent;

  @override
  void initState() {
    super.initState();
    coursecontent = [
      CourseContent(
          title: "Assignments",
          subtitle: "Tap to view assignment related to this course",
          type: "folder",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubscribedCourseAssignmentScreen(),
              ),
            );
          }),
      CourseContent(
          title: "Exam Notifications",
          subtitle: "Tap to view notification related to this course",
          type: "folder",
          onPressed: () {}),
      CourseContent(
          title: "Others",
          subtitle: "Tap to view other details related to this course",
          type: "folder",
          onPressed: () {}),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/etutor1.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 260),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Expanded(
                    child: Text("Course Contents",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25))),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: coursecontent.length,
                itemBuilder: (context, index) => CourseCard(
                  title: coursecontent[index].title,
                  subtitle: coursecontent[index].subtitle,
                  // type: coursecontent[index].type,
                  // onPressed: coursecontent[index].onPressed,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
