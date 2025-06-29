import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/performace_index/widgets/catergory_progress.dart';
import 'package:etutor/features/performace_index/widgets/course_progress.dart';
import 'package:etutor/features/performace_index/widgets/monthly_progress.dart';
import 'package:etutor/features/performace_index/widgets/overall_progress.dart';
import 'package:etutor/features/performace_index/widgets/weekly_progress.dart';
import 'package:flutter/material.dart';

class PerformanceIndexScreen extends StatelessWidget {
  const PerformanceIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Row(
          children: [
            //BackButton(),
            Text(
              "Student Performance Index",
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
                  "Overall Completion Status",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              OverallCompletionStatus(),
              SizedBox(height: 10),
              CatergoryProgress(),
          
              // Course Wise Completion Status
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Course Wise Progress",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              CategoryProgressChart(),
          
              // Weekly Test Analysis
              SizedBox(height: 30),Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Weekly Progress",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              WeeklyProgress(),
              SizedBox(height: 10),

              // Weekly Test Analysis
              SizedBox(height: 30),Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Monthly Progress",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              MonthlyProgress(),
              SizedBox(height: 30),
            ],
          ),
        ),
      )),
    );
  }
}
