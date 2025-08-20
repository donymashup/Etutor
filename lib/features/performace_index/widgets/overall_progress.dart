import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/chapter_analysis/model/chapter_analysis_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OverallCompletionStatus extends StatelessWidget {
  final int overall; // make nullable
  // final Tests? tests;
  // final Materials? materials;
  // final Materials? videos;

  const OverallCompletionStatus({
    super.key,
    required this.overall,
    // this.tests,
    // this.materials,
    // this.videos,
  });

  @override
  Widget build(BuildContext context) {
   // double percentage = ((overall ?? 0).clamp(0, 100)) / 100;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.greyBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 20.0,
            percent : double.parse(overall.toString())/100,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$overall %",
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Completed",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            backgroundColor: Colors.grey.shade300,
            progressColor: const Color(0xFF005BAC),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              LegendItem(color: AppColor.orangeBarGraph, label: "Learning Progress"),
              SizedBox(width: 20),
              LegendItem(color: Color(0xFF1565C0), label: "Total Learning"),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label}); // <-- made const

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
