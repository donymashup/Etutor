import 'dart:ffi';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/quiz/widgets/bullet_point.dart';
import 'package:etutor/features/subscribed_course/provider/bookmark_provider.dart';
import 'package:etutor/features/subscribed_course/screens/exam_webview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizInstructionPage extends StatefulWidget {
  final String duration;
  final String questions;
  final String testName;
  final String testid;
  final bool isMain;


  QuizInstructionPage({
    super.key,
    required this.duration,
    required this.questions,
    required this.testName,
    required this.testid,
 //   required this.url,
    required this.isMain,
  });

  @override
  State<QuizInstructionPage> createState() => _QuizInstructionPageState();
}

class _QuizInstructionPageState extends State<QuizInstructionPage> {
  UserDetailsProvider userDetailsProvider = UserDetailsProvider();
  BookmarkProvider bookmarkProvider = BookmarkProvider();

  @override
  void initState() {
    super.initState();
     context.read<BookmarkProvider>().checkBookMark(
     context: context, contentid: widget.testid, type: 'practice');
   
  }

  @override
  Widget build(BuildContext context) {
    userDetailsProvider = context.watch<UserDetailsProvider>();
   bookmarkProvider = context.watch<BookmarkProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CustomBackButton(),
        ),
        title: const Text(
          "Quiz Instructions",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:  widget.isMain  ? null
           : IconButton(
            onPressed: bookmarkProvider.isLoading
                ? null
                : () async {
                    await context.read<BookmarkProvider>().makeBookMark(
                      context: context,
                      contentid: widget.testid,
                      type: 'practice',
                    );
                  },
            icon: bookmarkProvider.isbookmarked
                ? const Icon(
                    Icons.bookmark_rounded,
                    color: Colors.white,
                    size: 24,
                  )
                : const Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                    size: 24,
                  ),
          ),
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.primaryColor.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Text(
                  widget.testName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 4,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),

          /// Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight( 
                    child: Row(
                      children: [
                        Expanded(
                          child: _infoCard(
                            icon: Icons.help_outline,
                            title: "${widget.questions} Questions",
                            subtitle: "1 point for correct, -1 for wrong",
                            color: Colors.blueGrey.shade800,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _infoCard(
                            icon: Icons.access_time,
                            title: "${widget.duration} Minutes",
                            subtitle: "Total duration of the quiz",
                            color: Colors.teal.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  const Text(
                    "Please read carefully",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 12),

                  const BulletPoint(
                    text: 'Correct and incorrect marks are shown for each and every question',
                  ),
                  const BulletPoint(
                    text: 'Tap on options to select the correct answer',
                  ),
                  const BulletPoint(
                    text: 'Save each answer before submitting',
                  ),
                  const BulletPoint(
                    text: 'Once saved, answers cannot be changed',
                  ),
                  const BulletPoint(
                    text: 'Press submit after saving to complete the exam',
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              shadowColor: AppColor.primaryColor.withOpacity(0.4),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExamWebView(
                    isMain: widget.isMain ,
                    testid: widget.testid,
                    userid: userDetailsProvider.userDetails.data!.id ?? "",
                    title: widget.testName,
                  ),
                ),
              );
            },
            child: const Text(
              'Start Quiz',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // centers inside
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
