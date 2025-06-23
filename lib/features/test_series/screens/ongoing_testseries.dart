import 'package:etutor/features/test_series/widgets/notestseries.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/test_series/widgets/test_series_card.dart';

class OngoingPage extends StatelessWidget {
  const OngoingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> ongoingTests = [
      {
        "title": "JEE Main Full Model I",
        "date": "20/05/25",
        "startTime": "10.00 AM",
        "endTime": "05.00 PM",
        "duration": "30 min",
        "marks": "0",
        "questions": "20",
      },
      {
        "title": "JEE Main Full Model II",
        "date": "22/05/25",
        "startTime": "11.00 AM",
        "endTime": "06.00 PM",
        "duration": "45 min",
        "marks": "0",
        "questions": "25",
      },
      // Add/remove items here to test the empty state
    ];

    if (ongoingTests.isEmpty) {
      return const noTestSeries();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: ongoingTests.length,
      itemBuilder: (context, index) {
        final test = ongoingTests[index];
        return TestSeriesCard(
          title: test["title"]!,
          date: test["date"]!,
          startTime: test["startTime"]!,
          endTime: test["endTime"]!,
          duration: test["duration"]!,
          marks: test["marks"]!,
          questionCount: test["questions"]!,
          onReview: (
            
          ) {
            // Handle attend/review action
          },
          isOngoing: true,
        );
      },
    );
  }
}
