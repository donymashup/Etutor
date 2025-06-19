import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/screens/no_data.dart';
import 'package:etutor/features/subscribed_course.dart/screens/subscribed_course_assignment_screen.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseOverview extends StatefulWidget {
  const SubscribedCourseOverview({super.key});

  @override
  State<SubscribedCourseOverview> createState() =>
      _SubscribedCourseOverviewState();
}

class CourseOverview {
  String title;
  String subtitle;
  IconData icon;
  Color iconBgcolor;
  Color iconcolor;
  void Function() onPressed;

  CourseOverview(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.iconBgcolor,
      required this.iconcolor,
      required this.onPressed});
}

class _SubscribedCourseOverviewState extends State<SubscribedCourseOverview> {
  List<CourseOverview> courseoverview = [
    CourseOverview(
        title: "Class 6",
        subtitle: "Class 6 subjects",
        icon: Icons.book,
        iconBgcolor: AppColor.greyCardBackground,
        iconcolor: AppColor.videoIconColor,
        onPressed: () {}),
    CourseOverview(
        title: "Class 7",
        subtitle: "Class 7 subjects",
        icon: Icons.book,
        iconBgcolor: AppColor.greyCardBackground,
        iconcolor: AppColor.videoIconColor,
        onPressed: () {}),
    CourseOverview(
        title: "Study Materials",
        subtitle: "Tap to view all other resources related to this course",
        icon: Icons.folder,
        iconBgcolor: AppColor.greyCardBackground,
        iconcolor: AppColor.fileIconColour,
        onPressed: () {}),
  ];

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
                    child: Text(
                  "Bridge Senior Class 6-7",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                )),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: courseoverview.length,
                itemBuilder: (context, index) => CourseCard(
                title: courseoverview[index].title, 
                subtitle: courseoverview[index].subtitle, 
                icon: courseoverview[index].icon, 
                iconBgColor: courseoverview[index].iconBgcolor, 
                iconColor: courseoverview[index].iconcolor,
                onPressed: courseoverview[index].onPressed
                ),
                ),
            ),
          ),
        ],
      )),
    );
  }
}
