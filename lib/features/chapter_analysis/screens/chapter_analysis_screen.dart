import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/chapter_analysis/model/chapter_analysis_model.dart';
import 'package:etutor/features/chapter_analysis/provider/chapter_analysis_provider.dart';
import 'package:etutor/features/chapter_analysis/widgets/materials_status_chart.dart';
import 'package:etutor/features/chapter_analysis/widgets/test_analysis_chart.dart';
import 'package:etutor/features/chapter_analysis/widgets/video_status_chart.dart';
import 'package:etutor/features/my_course/provider/my_course_provider.dart';
import 'package:etutor/features/performace_index/widgets/overall_progress.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/academicons.dart';
import 'package:provider/provider.dart';

class ChapterAnalysisScreen extends StatefulWidget {
  final String chapterid;
  final String packageid;

  const ChapterAnalysisScreen({
    super.key,
    required this.chapterid,
    required this.packageid,
  });

  @override
  State<ChapterAnalysisScreen> createState() => _ChapterAnalysisScreenState();
}

class _ChapterAnalysisScreenState extends State<ChapterAnalysisScreen> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final batchId = context.read<MyCourseProvider>().batchid;
    await context.read<ChapterAnalysisProvider>().fetchChapterAnalysis(
          context: context,
          packageid: widget.packageid,
          batchid: batchId,
          chapterid: widget.chapterid,
        );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ watch provider here
    final chapterAnalysisProvider = context.watch<ChapterAnalysisProvider>();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: const Text(
          "Chapter Analysis",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Overall Chapter Analysis",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                OverallCompletionStatus(
                  overall:
                      chapterAnalysisProvider.chapterAnalysis?.data?.overall ??
                          0,
                  // tests: chapterAnalysisProvider.chapterAnalysis?.data?.tests,
                  // materials:
                  //     chapterAnalysisProvider.chapterAnalysis?.data?.materials,
                  // videos: chapterAnalysisProvider.chapterAnalysis?.data?.videos,
                ),
                const SizedBox(height: 10),
                TestAnalysisChart(
                  correct:double.parse(chapterAnalysisProvider.chapterAnalysis?.data?.tests?.questions!.count!.correct.toString() ?? ''),
                  unanswered: double.parse(chapterAnalysisProvider.chapterAnalysis?.data?.tests?.questions!.count!.incorrect.toString() ?? ''), 
                  wrong:double.parse(chapterAnalysisProvider.chapterAnalysis?.data?.tests?.questions!.count!.unattended.toString() ?? ''),
                  // count: Count(
                  //   correct: chapterAnalysisProvider
                  //           .chapterAnalysis?.data?.tests?.correct ??
                  //       0,
                  //   incorrect: chapterAnalysisProvider
                  //           .chapterAnalysis?.data?.tests?.incorrect ??
                  //       0,
                  //   unattended: chapterAnalysisProvider
                  //           .chapterAnalysis?.data?.tests?.unattended ??
                  //       0,
                  // ),
                ),
                const SizedBox(height: 20),
                const VideoStatusChart(),
                const SizedBox(height: 20),
                const MaterialsStatusChart(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
