import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_subject_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseSubject extends StatefulWidget {
  const SubscribedCourseSubject({super.key});

  @override
  State<SubscribedCourseSubject> createState() => _SubscribedCourseSubjectState();
}

class _SubscribedCourseSubjectState extends State<SubscribedCourseSubject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/subname1.jpg'),
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
                    child: Expanded(child: Text("Science",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25))),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),CourseSubjectCard(subjectName: "SEPERATION OF SUBSTANCES", subjectImage: "assets/images/sub2.jpg", onPressed: (){}),
                    SizedBox(height: 10),CourseSubjectCard(subjectName: "SORTING MATERIALS", subjectImage: "assets/images/sub1.jpg", onPressed: (){}),
                    SizedBox(height: 10),CourseSubjectCard(subjectName: "FIBRE TO FABRIC", subjectImage: "assets/images/sub3.jpg", onPressed: (){}),
                    SizedBox(height: 10), CourseSubjectCard(subjectName: "COMPONENTS OF FOOD", subjectImage: "assets/images/sub4.jpg", onPressed: (){}),
                    SizedBox(height: 10), 
                  ],
                ),
              ),  
            ],
          )
        ),
      ),
    );
  }
}