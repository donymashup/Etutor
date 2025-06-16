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

class _SubscribedCourseOverviewState extends State<SubscribedCourseOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
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
                    "Bridge Senior Class 6-7 ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CourseCard(
                    title: "Class 6",
                    subtitle: "Foundation of class 6",
                    icon: Icons.book,
                    iconBgColor: AppColor.greyCardBackground,
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                                          SubscribedCourseAssignmentScreen()));
                    },
                    iconColor: AppColor.videoIconColor,
                  ),
                  SizedBox(height: 10),
                  CourseCard(
                    title: "Class 7",
                    subtitle: "Class 7 subjects",
                    icon: Icons.book,
                    iconBgColor: AppColor.greyCardBackground,
                    onPressed: () { Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                                          SubscribedCourseAssignmentScreen()));},
                    iconColor: AppColor.videoIconColor,
                  ),
                  SizedBox(height: 10),
                  CourseCard(
                    title: "Study Materials",
                    subtitle:
                        "Tap to view all other resources related to this course",
                    icon: Icons.folder,
                    iconBgColor: AppColor.greyCardBackground,
                    onPressed: () { Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                                          NoData()));},
                    iconColor: AppColor.fileIconColour,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
