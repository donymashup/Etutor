import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/my_course/widgets/course_curriculum_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCurriculum extends StatefulWidget {
  @override
  State<CourseCurriculum> createState() => _CourseCurriculumState();
}
class _CourseCurriculumState extends State<CourseCurriculum> {
    CourseDetailsProvider courseDetailsProvider = CourseDetailsProvider();

  @override
  Widget build(BuildContext context) {
    courseDetailsProvider = context.watch<CourseDetailsProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                  courseDetailsProvider.exploreChapter.length,
                  (index)
                  {
                    final chapter = courseDetailsProvider.exploreChapter[index];
                    return CourseCurriculumCard(
                      title: chapter.chapName ?? '',
                      classname: chapter.className ?? '',
                      subject: chapter.subjectName ?? '',
                      contents: chapter.contents ?? [],
                      );}
                      ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
