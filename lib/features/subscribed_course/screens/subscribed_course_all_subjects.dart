import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_chapters.dart';
import 'package:etutor/features/subscribed_course/widgets/subject_overview_card.dart';
import 'package:etutor/features/subscribed_course/widgets/subject_shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscribedCourseAllSubjects extends StatefulWidget {
  final String packageClassId;
  final String className;
  final String classDescription;
  const SubscribedCourseAllSubjects({
    super.key,
    required this.packageClassId,
    required this.classDescription,
    required this.className,
  });

  @override
  State<SubscribedCourseAllSubjects> createState() =>
      _SubscribedCourseAllSubjectsState();
}

class _SubscribedCourseAllSubjectsState
    extends State<SubscribedCourseAllSubjects> {
  SubcribedCourseProvider subcribedCourseProvider = SubcribedCourseProvider();
    @override
  void initState() {
    super.initState();
    load();
  }

    Future<void> load() async {
    await context
        .read<SubcribedCourseProvider>().fetchClassSubjects(context: context, packageClassId: widget.packageClassId);
  }

  @override
  Widget build(BuildContext context) {
    final subcribedCourseProvider = context.watch<SubcribedCourseProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
        title: Text(
          widget.className,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColor.whiteColor,
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Learn With Confidence - ${widget.classDescription}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Text("Step Into a World of Knowledge Across Every Core Subject",
                    style: TextStyle(fontSize: 14)),
                SizedBox(height: 10),
                subcribedCourseProvider.isLoadingsubjects 
                ? SubjectShimmerLoader()
               : Center(
                   child: subcribedCourseProvider.courseSubjects!.data!.isEmpty
                  ? Center(child:Text('No Subjects'))
                  :Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.start,
                      children: [
                        ...List.generate(
                            subcribedCourseProvider.courseSubjects!.data!.length,
                            (index) {
                              final subject = subcribedCourseProvider.courseSubjects!.data![index];
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SubscribedCourseChapters(
                                              subjectImage: subject.subjectImage!,
                                              subjectName:subject.subjectName!,
                                              packageSubjectId:subject.packageSubjectId!,))),
                                child: SubjectOverviewCard(
                                    title: subject.subjectName ?? "",
                                    description:
                                        subject.subjectDescription ?? "",
                                    subjectImage:
                                        subject.subjectImage ?? ""),
                              );
                            }
                        )
                      ],
                    ),
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
