import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/chapter_card_overview_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/listview_shimmer_loader.dart';
import 'package:etutor/features/subscribed_course/widgets/practice_test_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscribedCoursesTests extends StatefulWidget {
  final String packageChapterId;
  const SubscribedCoursesTests({super.key ,required this.packageChapterId });

  @override
  State<SubscribedCoursesTests> createState() => _SubscribedCoursesTestsState();
}

class _SubscribedCoursesTestsState extends State<SubscribedCoursesTests> {
  ChapterCardOverviewProvider chapterProvider =ChapterCardOverviewProvider();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void>_load()async{
    await context.read<ChapterCardOverviewProvider>().fetchPracticeTest(context,widget.packageChapterId);
  }

  @override
  Widget build(BuildContext context) {
    chapterProvider = context.watch<ChapterCardOverviewProvider>();
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
      body:chapterProvider.isTestLoading 
      ?ListviewShimmerLoader() 
      : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: chapterProvider.practiceTest.isEmpty
           ? Center(child: Text("No Practice Tests"),)
           :Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: chapterProvider.practiceTest.length,
                  itemBuilder: (context, index)
                  {
                  final practiceTest = chapterProvider.practiceTest[index];
                    return PracticeTestCard(
                    testName: practiceTest.name ?? "",
                    testId: practiceTest.id ?? '',
                    questions: practiceTest.questionsCount.toString(),
                    testDuration: practiceTest.duration.toString(),
                    packageClassId:widget.packageChapterId,
                    isAttended: practiceTest.attended!,
                  );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
