import 'package:etutor/features/test_series/widgets/test_series_card.dart';
import 'package:flutter/material.dart';

class AttendedPage extends StatelessWidget {
  const AttendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      children: [
        TestSeriesCard(
          title: 'JEE Main Full Model I',
          date: '20/05/25',
          startTime: '10.00 AM',
          endTime: '05.00 AM',
          duration: '30 min',
          marks: '20',
          questionCount: '10',
          onReview: () {
          },
        ),
        TestSeriesCard(
          title: 'JEE Main Full Model I',
          date: '20/05/25',
          startTime: '10.00 AM',
          endTime: '05.00 AM',
          duration: '30 min',
          marks: '20',
          questionCount: '10',
          onReview: () {
          },
        ),
        TestSeriesCard(
          title: 'JEE Main Full Model I',
          date: '20/05/25',
          startTime: '10.00 AM',
          endTime: '05.00 AM',
          duration: '30 min',
          marks: '20',
          questionCount: '10',
          onReview: () {
          },
        ),
      ],
    );
  }
}
