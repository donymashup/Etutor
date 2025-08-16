import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/quiz/screens/quiz_instruction_screen.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCoursesTests extends StatefulWidget {
  const SubscribedCoursesTests({super.key});

  @override
  State<SubscribedCoursesTests> createState() => _SubscribedCoursesTestsState();
}

class Tests {
  String title;
  String subtitle;
  String type;
  void Function() onPressed;

  Tests(
      {required this.title,
      required this.subtitle,
      required this.type,
      required this.onPressed});
}

class _SubscribedCoursesTestsState extends State<SubscribedCoursesTests> {
  late List<Tests> tests;

  @override
  void initState() {
    super.initState();
    tests = [
      Tests(
        title: "Sample Test 1",
        subtitle: "Tap to attend the test",
        type: "test",
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QuizInstructionPage()));
        },
      ),
      Tests(
        title: "Sample Test 2",
        subtitle: "Tap to attend the test",
        type: "test",
        onPressed: () {
          // Navigate to test details or perform some action
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QuizInstructionPage()));
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Tests",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: tests.length,
                  itemBuilder: (context, index) => CourseCard(
                    className: tests[index].title,
                    classDescription: tests[index].subtitle,
                    packageClassId: '1',
                    // type: tests[index].type,
                    // onPressed: tests[index].onPressed,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
