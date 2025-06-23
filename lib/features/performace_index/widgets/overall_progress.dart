import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class OverallCompletionStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double percentage = 0.75; // 75%

    return Container(
      decoration: BoxDecoration(
        color: AppColor.greyBackground,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 20.0,
            percent: percentage,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${(percentage * 100).toInt()}%",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Completed",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            backgroundColor: Color(0xFF005BAC), // Blue ring for total learning
            progressColor: Color(0xFFFF9800), // Orange ring for learning progress
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LegendItem(color: Color(0xFFFF9800), label: "Learning Progress"),
              SizedBox(width: 20),
              LegendItem(color: Color(0xFF005BAC), label: "Total Learning"),
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

  const LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}