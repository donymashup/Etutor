import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/chapter_analysis/provider/chapter_analysis_provider.dart';
import 'package:etutor/features/chapter_analysis/widgets/materials_status_chart.dart';
import 'package:etutor/features/chapter_analysis/widgets/test_analysis_chart.dart';
import 'package:etutor/features/chapter_analysis/widgets/timevsmarkschart.dart';
import 'package:etutor/features/chapter_analysis/widgets/video_status_chart.dart';
import 'package:etutor/features/my_course/provider/my_course_provider.dart';
import 'package:etutor/features/performace_index/widgets/overall_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
    final chapterAnalysisProvider = context.watch<ChapterAnalysisProvider>();
    if (chapterAnalysisProvider.isLoadingChapterAnalysis) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: const EdgeInsets.only(left: 20, bottom: 10),
                height: 16,
                width: 120,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 260,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(3, (index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 30,
                      height: (100 + (index * 20)).toDouble(),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 16,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ],
        ),
      );
    }
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
                ),
                const SizedBox(height: 10),
                TestAnalysisChart(
                  correct: double.parse(chapterAnalysisProvider.chapterAnalysis
                          ?.data?.tests?.questions!.count!.correct
                          .toString() ??
                      ''),
                  unanswered: double.parse(chapterAnalysisProvider
                          .chapterAnalysis
                          ?.data
                          ?.tests
                          ?.questions!
                          .count!
                          .incorrect
                          .toString() ??
                      ''),
                  wrong: double.parse(chapterAnalysisProvider.chapterAnalysis
                          ?.data?.tests?.questions!.count!.unattended
                          .toString() ??
                      ''),
                ),
                const SizedBox(height: 20),
                TimeVsMarksChart(
                  times: (chapterAnalysisProvider
                              .chapterAnalysis?.data?.tests?.questions?.time !=
                          null)
                      ? [
                          (chapterAnalysisProvider.chapterAnalysis?.data?.tests
                                      ?.questions?.time?.correct ??
                                  0)
                              .toDouble(),
                          (chapterAnalysisProvider.chapterAnalysis?.data?.tests
                                      ?.questions?.time?.incorrect ??
                                  0)
                              .toDouble(),
                          (chapterAnalysisProvider.chapterAnalysis?.data?.tests
                                      ?.questions?.time?.unattended ??
                                  0)
                              .toDouble(),
                        ]
                      : [],
                  marks: (chapterAnalysisProvider.chapterAnalysis?.data?.tests
                              ?.questions?.perTime !=
                          null)
                      ? [
                          (chapterAnalysisProvider.chapterAnalysis?.data?.tests
                                      ?.questions?.perTime?.correct ??
                                  0)
                              .toDouble(),
                          (chapterAnalysisProvider.chapterAnalysis?.data?.tests
                                      ?.questions?.perTime?.incorrect ??
                                  0)
                              .toDouble(),
                          (chapterAnalysisProvider.chapterAnalysis?.data?.tests
                                      ?.questions?.perTime?.unattended ??
                                  0)
                              .toDouble(),
                        ]
                      : [],
                ),
                const SizedBox(height: 20),
                VideoStatusChart(
                  watched: chapterAnalysisProvider
                          .chapterAnalysis?.data?.videos?.viewed ??
                      0,
                  total: chapterAnalysisProvider
                          .chapterAnalysis?.data?.videos?.total ??
                      0,
                ),
                const SizedBox(height: 20),
                MaterialsStatusChart(
                  materialstotal: chapterAnalysisProvider
                          .chapterAnalysis?.data?.materials?.total ??
                      0,
                  materialswatched: chapterAnalysisProvider
                          .chapterAnalysis?.data?.materials?.viewed ??
                      0,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
