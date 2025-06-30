import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/chapter_analysis/widgets/materials_status_chart.dart';
import 'package:etutor/features/chapter_analysis/widgets/test_analysis_chart.dart';
import 'package:etutor/features/chapter_analysis/widgets/video_status_chart.dart';
import 'package:etutor/features/performace_index/widgets/catergory_progress.dart';
import 'package:etutor/features/performace_index/widgets/course_progress.dart';
import 'package:etutor/features/performace_index/widgets/monthly_progress.dart';
import 'package:etutor/features/performace_index/widgets/overall_progress.dart';
import 'package:etutor/features/performace_index/widgets/weekly_progress.dart';
import 'package:flutter/material.dart';

class ChapterAnalysisScreen extends StatelessWidget {
  const ChapterAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Chapter Analysis",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              
              // Overall Completion Status
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Overall Chapter Analysis",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              OverallCompletionStatus(),
              SizedBox(height: 10),
              TestAnalysisChart(),
              SizedBox(height: 20),
              VideoStatusChart(),
              SizedBox(height: 20),
              MaterialsStatusChart(),

            ],
          ),
        ),
      )),
    );
  }
}
