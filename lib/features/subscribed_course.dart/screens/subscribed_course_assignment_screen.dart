import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseAssignmentScreen extends StatefulWidget {
  const SubscribedCourseAssignmentScreen({super.key});

  @override
  State<SubscribedCourseAssignmentScreen> createState() => _SubscribedCourseAssignmentScreenState();
}

class _SubscribedCourseAssignmentScreenState extends State<SubscribedCourseAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Assignments",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                SizedBox(height: 15),
                CourseCard(
                  title: "Experiment 4.5", 
                  subtitle: "Tap to view this video", 
                  icon: Icons.videocam, 
                  iconBgColor: AppColor.lighBlueBackground,
                  onPressed: (){}, 
                  iconColor: AppColor.videoIconColor
                  ),
                SizedBox(height: 10),
                 CourseCard(
                  title: "Chapter 2 Notes", 
                  subtitle: "Tap to view this pdf", 
                  icon: Icons.picture_as_pdf, 
                  iconBgColor: AppColor.lightRedCardBackground,
                  onPressed: (){}, 
                  iconColor: AppColor.redBarGraph
                  ),
                SizedBox(height: 10),
                 CourseCard(
                  title: "Figure 2.9", 
                  subtitle: "Tap to view the image", 
                  icon: Icons.image_rounded, 
                  iconBgColor: AppColor.lightGreenCardBackground,
                  onPressed: (){}, 
                  iconColor: AppColor.greenBarGraph
                  ),
                SizedBox(height: 10), CourseCard(
                  title: "Sample Test", 
                  subtitle: "Tap to attend the test", 
                  icon: Icons.calendar_month, 
                  iconBgColor: AppColor.lightVioletCardBackground,
                  onPressed: (){}, 
                  iconColor: AppColor.testIconColour,
                  ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}