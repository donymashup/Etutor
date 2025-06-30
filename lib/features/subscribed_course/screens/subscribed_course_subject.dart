import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/widgets/course_subject_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseSubject extends StatefulWidget {
  const SubscribedCourseSubject({super.key});

  @override
  State<SubscribedCourseSubject> createState() =>
      _SubscribedCourseSubjectState();
}

class Subject {
  String subjectName;
  String subjectImage;

  Subject({required this.subjectName, required this.subjectImage});
}

class _SubscribedCourseSubjectState extends State<SubscribedCourseSubject> {
  List<Subject> subject = [
    Subject(
        subjectName: "SEPERATION OF SUBSTANCES",
        subjectImage: 'assets/images/subname1.jpg'),
    Subject(
        subjectName: "SORTING MATERIALS",
        subjectImage: 'assets/images/subname2.jpg'),
    Subject(
        subjectName: "FIBRE TO FABRIC",
        subjectImage: 'assets/images/subname3.jpg'),
    Subject(
        subjectName: "COMPONENTS OF FOOD",
        subjectImage: 'assets/images/subname4.jpg'),
    Subject(
        subjectName: "SEPERATION OF SUBSTANCES",
        subjectImage: 'assets/images/subname1.jpg'),
    Subject(
        subjectName: "SORTING MATERIALS",
        subjectImage: 'assets/images/subname2.jpg'),
    Subject(
        subjectName: "FIBRE TO FABRIC",
        subjectImage: 'assets/images/subname3.jpg'),
    Subject(
        subjectName: "COMPONENTS OF FOOD",
        subjectImage: 'assets/images/subname4.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/subname1.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Text("Science",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
                )
              ],
            ),
            Expanded(
              // height: MediaQuery.of(context).size.height - 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView.builder(
                  itemCount: subject.length,
                  itemBuilder: (context, index) => CourseSubjectCard(
                      subjectName: subject[index].subjectName,
                      subjectImage: subject[index].subjectImage,
                      onPressed: () {}),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
