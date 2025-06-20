import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_card.dart';
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
  IconData icon;
  Color iconBgcolor;
  Color iconcolor;
  void Function() onPressed;

  Assignments(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.iconBgcolor,
      required this.iconcolor,
      required this.onPressed});
}

class _SubscribedCourseAssignmentScreenState
    extends State<SubscribedCourseAssignmentScreen> {
  List<Assignments> assignments = [
    Assignments(title: "Experiment 4.5", 
    subtitle: "Tap to view this video", 
    icon: Icons.videocam, 
    iconBgcolor: AppColor.lighBlueBackground, 
    iconcolor: AppColor.videoIconColor, 
    onPressed: (){},
    ),
    Assignments(title: "Chapter 2 Notes", 
    subtitle: "Tap to view this pdf", 
    icon: Icons.picture_as_pdf, 
    iconBgcolor: AppColor.lightRedCardBackground, 
    iconcolor: AppColor.pdfIconColour, 
    onPressed: (){},
    ),
    Assignments(title: "Figure 2.9", 
    subtitle: "Tap to view this image", 
    icon: Icons.image, 
    iconBgcolor: AppColor.lightGreenCardBackground, 
    iconcolor: AppColor.greenBarGraph, 
    onPressed: (){},
    ),
     Assignments(title: "Sample Test", 
    subtitle: "Tap to attend the test", 
    icon: Icons.calendar_month, 
    iconBgcolor: AppColor.lightVioletCardBackground, 
    iconcolor: AppColor.testIconColour, 
    onPressed: (){},
    ),
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
                child: ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder:(context, index) => CourseCard(
                title: assignments[index].title, 
                subtitle: assignments[index].subtitle, 
                icon: assignments[index].icon, 
                iconBgColor: assignments[index].iconBgcolor, 
                onPressed: assignments[index].onPressed, 
                iconColor: assignments[index].iconcolor),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
