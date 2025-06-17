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
        child:Padding(
          padding: const EdgeInsets.all(30.0),
          child:
          Column(
            children: [
              // Expanded(
              //   child: GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.1), 
              //     itemBuilder: (context, index) => SubjectOverviewCard(title: "Social Science", description: "Understanding Our Past and Present", subjectImage: "assets/images/subname1.jpg")),
              // )
              Center(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    SubjectOverviewCard(title: "Social Science", description: "Understanding Our Past and Present", subjectImage: "assets/images/subname1.jpg"),
                    SubjectOverviewCard(title: "Social Science", description: "Understanding Our Past and Present", subjectImage: "assets/images/subname1.jpg"),
                    SubjectOverviewCard(title: "Social Science", description: "Understanding Our Past and Present", subjectImage: "assets/images/subname1.jpg")
                  ],
                ),
              )          
            ],
          )
        ) ,
      ),
    );
  }
}