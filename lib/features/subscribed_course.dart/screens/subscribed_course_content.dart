import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseContent extends StatefulWidget {
  const SubscribedCourseContent({super.key});

  @override
  State<SubscribedCourseContent> createState() => _SubscribedCourseContentState();
}

class _SubscribedCourseContentState extends State<SubscribedCourseContent> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  child: Expanded(child: Text("Course Contents",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25))),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CourseCard(
                    title: "Assignments",
                    subtitle: "Tap to view assignment related to this course", 
                    icon: Icons.folder, 
                    iconBgColor: AppColor.greyCardBackground,
                    onPressed: (){}, 
                    iconColor: AppColor.fileIconColour,),
                  SizedBox(height: 10),
                  CourseCard(
                    title: "Exam Notifications",
                    subtitle: "Tap to view exam notifications related to this course", 
                    icon: Icons.folder, 
                    iconBgColor: AppColor.greyCardBackground,
                    onPressed: (){}, 
                    iconColor: AppColor.fileIconColour,),
                  SizedBox(height: 10),
                  CourseCard(
                    title: "Others",
                    subtitle: "Tap to view additional details related to this course", 
                    icon: Icons.folder, 
                    iconBgColor: AppColor.greyCardBackground,
                    onPressed: (){}, 
                    iconColor: AppColor.fileIconColour,),
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