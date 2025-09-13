import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/quiz/screens/quiz_instruction_screen.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_all_subjects.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class PracticeTestCard extends StatefulWidget {
  final String testName;
  final String testDuration;
  final String questions;
  final String testId;

  const PracticeTestCard({
    super.key,
    required this.testName,
    required this.testDuration,
    required this.questions,
    required this.testId,
  });

  @override
  State<PracticeTestCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<PracticeTestCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizInstructionPage(duration: widget.testDuration, questions: widget.questions,testid: widget.testId,testName: widget.testName,),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyStroke),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
              leadingIconCard(
            Iconify(
              Mdi.timer,
              size: 30,
              color: AppColor.testIconColour,
            ),
            AppColor.lightVioletCardBackground),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.testName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${widget.testDuration} mins",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leadingIconCard(Widget icon, Color bgColor) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: bgColor),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: icon,
        ));
  }
}
