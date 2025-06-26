import 'package:etutor/features/subscribed_course/screens/subscribed_course_subject.dart';
import 'package:etutor/features/subscribed_course/widgets/subject_overview_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseAllSubjects extends StatefulWidget {
  const SubscribedCourseAllSubjects({super.key});

  @override
  State<SubscribedCourseAllSubjects> createState() => _SubscribedCourseAllSubjectsState();
}

class _SubscribedCourseAllSubjectsState extends State<SubscribedCourseAllSubjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Learn With Confidence – Grade 6",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                Text("Step Into a World of Knowledge Across Every Core Subject",style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                Center(
                    child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubscribedCourseSubject()));
                      },
                      child: SubjectOverviewCard(
                        title: "Social Science",
                        description: "Understanding Our Past and Present",
                        subjectImage: "assets/images/subname1.jpg",
                      ),
                      ),
                      GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubscribedCourseSubject()));
                      },
                      child: SubjectOverviewCard(
                        title: "Social Science",
                        description: "Understanding Our Past and Present",
                        subjectImage: "assets/images/subname1.jpg",
                      ),
                      ),
                      GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubscribedCourseSubject()));
                      },
                      child: SubjectOverviewCard(
                        title: "Social Science",
                        description: "Understanding Our Past and Present",
                        subjectImage: "assets/images/subname1.jpg",
                      ),
                      ),
                    ],
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}