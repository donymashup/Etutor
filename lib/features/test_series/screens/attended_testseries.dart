import 'package:etutor/features/test_series/widgets/notestseries.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/test_series/widgets/test_series_card.dart';

class AttendedPage extends StatelessWidget {
  const AttendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> attendedTests = [
      {
        "title": "JEE Main Full Model I",
        "date": "20/05/25",
        "startTime": "10.00 AM",
        "endTime": "05.00 PM",
        "duration": "30 min",
        "marks": "20",
        "questions": "10",
      },
      {
        "title": "JEE Main Full Model II",
        "date": "22/05/25",
        "startTime": "11.00 AM",
        "endTime": "06.00 PM",
        "duration": "60 min",
        "marks": "50",
        "questions": "25",
      },
      // Add/remove items here to test empty state
    ];

    if (attendedTests.isEmpty) {
      return const noTestSeries();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: attendedTests.length,
      itemBuilder: (context, index) {
        final test = attendedTests[index];
        return TestSeriesCard(
          title: test["title"]!,
          date: test["date"]!,
          startTime: test["startTime"]!,
          endTime: test["endTime"]!,
          duration: test["duration"]!,
          marks: test["marks"]!,
          questionCount: test["questions"]!,
          onReview: () {
            // Handle review tap
          },
        );
      },
    );
  }
}
