import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:flutter/material.dart';

class CourseOverviewScreen extends StatefulWidget {
  const CourseOverviewScreen({super.key});

  @override
  State<CourseOverviewScreen> createState() => _CourseOverviewState();
}

class Testimonials {
  String username;
  String userimage;
  String description;

  Testimonials({
    required this.username,
    required this.description,
    required this.userimage,
  });
}

class _CourseOverviewState extends State<CourseOverviewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Class 06 Foundation 25-26",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  Text("Fundamental Concepts and Skills for Beginners",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Text("30,000 rs",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 10),
                  Text("Welcome to the Class 06 Foundation Course section of our app! Here, we offer a comprehensive learning experience designed to help students excel in their academic journey. Our course provides a wide range of resources to support students in four key subjects: Science, Social Science, Mathematics, and Mental Ability. Through a combination of engaging videos, detailed study materials, practice tests, and live classes, we strive to enhance students' understanding and knowledge in these subjects. Our video lessons are carefully crafted by expert educators, covering each topic extensively and providing clear explanations. Students can access these videos at any time, allowing them to learn at their own pace and revisit concepts as needed. To further reinforce learning, we offer a vast collection of study materials. ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,),textAlign: TextAlign.justify,),
                ],
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}