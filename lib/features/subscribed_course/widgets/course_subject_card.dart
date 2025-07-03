import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/chapter_analysis/screens/chapter_analysis_screen.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_materials.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_vedio.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_courses_tests.dart';
import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bxs.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class CourseSubjectCard extends StatelessWidget {
  final String subjectName;
  final String subjectImage;
  final bool isExpanded;
  final VoidCallback onTap;

  const CourseSubjectCard({
    required this.subjectName,
    required this.subjectImage,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 20, right: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.greyStroke),
          color: Colors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: AssetImage(subjectImage),
                          fit: BoxFit.cover,
                        ),
                        color: AppColor.greyIcon,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        subjectName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                        isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubscribedCourseVedio()),
                                  );
                                },
                                child: _iconWithLabel(
                                    Iconify(
                                      Bxs.video,
                                      size: 30,
                                      color: AppColor.fileIconColour,
                                    ),
                                    'Videos',
                                    ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SubscribedCourseMaterials()),
                                  );
                                },
                                child: _iconWithLabel(
                                    Iconify(
                                      Mdi.document,
                                      size: 30,
                                      color: AppColor.videoIconColor,
                                    ),
                                    'Materials',
                                    ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SubscribedCoursesTests()),
                                  );
                                },
                                child: _iconWithLabel(
                                    Iconify(
                                      Mdi.timer,
                                      size: 30,
                                      color: AppColor.greenchaptertest,
                                    ),
                                    'Tests',
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: LinearProgressIndicator(
                                    value: 0.60,
                                    backgroundColor: Colors.grey.shade300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("60%"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChapterAnalysisScreen()),
                                );
                              },
                              text: "Chapter Analysis",
                              buttoncolor: AppColor.fileIconColour,
                              textColor: AppColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }   

  Widget _iconWithLabel(Widget icon, String label) {
    return Column(
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: Center(child: icon),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
