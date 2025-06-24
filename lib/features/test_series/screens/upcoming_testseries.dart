import 'package:etutor/features/test_series/widgets/notestseries.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/test_series/widgets/test_series_card.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> upcomingTests = [
      // {
      //   "title": "JEE Main Full Model I",
      //   "date": "25/06/25",
      //   "startTime": "10.00 AM",
      //   "endTime": "12.00 PM",
      //   "duration": "30 min",
      //   "marks": "20",
      //   "questions": "10",
      // },
      // {
      //   "title": "NEET Mock Test",
      //   "date": "26/06/25",
      //   "startTime": "11.00 AM",
      //   "endTime": "01.00 PM",
      //   "duration": "45 min",
      //   "marks": "50",
      //   "questions": "20",
      // },
      // Empty the list above to trigger noTestSeries widget
    ];

    if (upcomingTests.isEmpty) {
      return const noTestSeries();
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: upcomingTests.length,
      itemBuilder: (context, index) {
        final test = upcomingTests[index];
        return TestSeriesCard(
          title: test["title"]!,
          date: test["date"]!,
          startTime: test["startTime"]!,
          endTime: test["endTime"]!,
          duration: test["duration"]!,
          marks: test["marks"]!,
          questionCount: test["questions"]!,
          isUpcoming: true,
        );
      },
    );
  }
}
