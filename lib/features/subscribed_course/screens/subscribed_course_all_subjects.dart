import 'package:etutor/features/subscribed_course/screens/subscribed_course_subject.dart';
import 'package:etutor/features/subscribed_course/widgets/subject_overview_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseAllSubjects extends StatefulWidget {
  const SubscribedCourseAllSubjects({super.key});

  @override
  State<SubscribedCourseAllSubjects> createState() =>
      _SubscribedCourseAllSubjectsState();
}

class AllSubjects {
  String? title;
  String? description;
  String? subjectImage;

  AllSubjects(
      {required this.title,
      required this.description,
      required this.subjectImage});
}

List<AllSubjects> allsubjects = [
  AllSubjects(
      title: "Science",
      description: "Exploring the Wonders of Nature and Everyday Phenomena",
      subjectImage: "assets/images/subname1.jpg"),
  AllSubjects(
      title: "Mathematics",
      description: "Building Logical Thinking Through Numbers and Patterns",
      subjectImage: "assets/images/subname.jpg"),
  AllSubjects(
      title: "Mental Ability",
      description:
          "Enhancing Reasoning Skills for Analytical and Critical Thinking",
      subjectImage: "assets/images/subname3.jpg"),
  AllSubjects(
      title: "Social Science",
      description: "Understanding Past and Present",
      subjectImage: "assets/images/subname2.jpg"),
];

class _SubscribedCourseAllSubjectsState
    extends State<SubscribedCourseAllSubjects> {
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
                Text(
                  "Learn With Confidence – Grade 6",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text("Step Into a World of Knowledge Across Every Core Subject",
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                Center(
                  child: Wrap(
                    spacing: 10,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                          allsubjects.length,
                          (index) => GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubscribedCourseSubject())),
                                child: SubjectOverviewCard(
                                    title: allsubjects[index].title ?? "",
                                    description:
                                        allsubjects[index].description ?? "",
                                    subjectImage:
                                        allsubjects[index].subjectImage ?? ""),
                              ))
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 SubscribedCourseSubject()));
                      //   },
                      //   child: SubjectOverviewCard(
                      //     title: "Social Science",
                      //     description: "Understanding Our Past and Present",
                      //     subjectImage: "assets/images/subname1.jpg",
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 SubscribedCourseSubject()));
                      //   },
                      //   child: SubjectOverviewCard(
                      //     title: "Social Science",
                      //     description: "Understanding Our Past and Present",
                      //     subjectImage: "assets/images/subname2.jpg",
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 SubscribedCourseSubject()));
                      //   },
                      //   child: SubjectOverviewCard(
                      //     title: "Social Science",
                      //     description: "Understanding Our Past and Present",
                      //     subjectImage: "assets/images/subname3.jpg",
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 SubscribedCourseSubject()));
                      //   },
                      //   child: SubjectOverviewCard(
                      //     title: "Social Science",
                      //     description: "Understanding Our Past and Present",
                      //     subjectImage: "assets/images/subname4.jpg",
                      //   ),
                      // ),
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
