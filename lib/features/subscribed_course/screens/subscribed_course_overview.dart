import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_all_subjects.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_content.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:etutor/features/subscribed_course/widgets/rating_modal.dart';
import 'package:flutter/material.dart';

class SubscribedCourseOverview extends StatefulWidget {
  const SubscribedCourseOverview({super.key});

  @override
  State<SubscribedCourseOverview> createState() =>
      _SubscribedCourseOverviewState();
}

class CourseOverview {
  String title;
  String subtitle;
  String type;
  void Function() onPressed;

  CourseOverview({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.onPressed,
  });
}

class _SubscribedCourseOverviewState extends State<SubscribedCourseOverview> {
  late List<CourseOverview> courseoverview;

  @override
  void initState() {
    super.initState();

    courseoverview = [
      CourseOverview(
        title: "Class 6",
        subtitle: "Class 6 subjects",
        type: "class",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscribedCourseAllSubjects(),
            ),
          );
        },
      ),
      CourseOverview(
        title: "Class 7",
        subtitle: "Class 7 subjects",
        type: "class",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscribedCourseAllSubjects(),
            ),
          );
        },
      ),
      CourseOverview(
        title: "Course Contents",
        subtitle: "Tap to view all other resources related to this course",
        type: "folder",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubscribedCourseContent(),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/oly1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomBackButton(),
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
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "International Social Studies Olympiad",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView.builder(
                      itemCount: courseoverview.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: courseoverview[index].onPressed,
                        child: CourseCard(
                          title: courseoverview[index].title,
                          subtitle: courseoverview[index].subtitle,
                          type: courseoverview[index].type,
                          onPressed: courseoverview[index].onPressed,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        backgroundColor: AppColor.secondaryColor,
                        onPressed: () {
                          showRatingDialog(context);
                        },
                        child: const Icon(Icons.star, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

