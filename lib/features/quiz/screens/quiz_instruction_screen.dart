import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/quiz/screen/new_test_page.dart';
import 'package:etutor/features/quiz/widgets/bullet_point.dart';
import 'package:flutter/material.dart';

class QuizInstructionPage extends StatelessWidget {
  final String duration;
  final String questions;
  const QuizInstructionPage({super.key,required this.duration, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: AppColor.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: CustomBackButton(),
                    ),
                    Text(
                      "Quiz Instructions",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20, color: AppColor.whiteColor),
                    ),
                  ],
                ),
                const Text(
                  'IQQM EXAM [08-06-2025]',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            color: AppColor.whiteColor,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: SizedBox(
                  width: 60,
                  height: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Brief explanation about this quiz',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.black87,
                          child: Icon(Icons.help_outline, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$questions Questions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '1 point for a correct answer, -1 for a wrong answer',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.black87,
                          child: Icon(Icons.access_time, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$duration Minutes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Total duration of the quiz',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Please read the text below carefully so you can understand it',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const BulletPoint(
                      text:
                          'Correct and incorrect marks are shown for each and every questions',
                    ),
                    const BulletPoint(
                      text: 'Tap on options to select the correct answer',
                    ),
                    const BulletPoint(
                      text:
                          'Save each exam answers before submitting (press save button)',
                    ),
                    const BulletPoint(
                      text: 'Once saved cannot be changed',
                    ),
                    const BulletPoint(
                      text:
                          'Press submit after saving the answers to complete exam (Press submit and end button)',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E6ECF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => TexViewQuizScreen())),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }
}
