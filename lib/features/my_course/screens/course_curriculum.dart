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
                      // names: chapter.contents!.map((content) => content.contentName ?? "").toList(),
                      // status: chapter.contents!.map((content) => content.status ?? "").toList(),
                      // link:chapter.contents!.map((content) => content.link ?? "").toList(),
                      // source: chapter.contents!.map((content) => content.source ?? "").toList(), 
                      // contentType: chapter.contents!.map((content) => content.contentType ?? "").toList(),
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
