import 'package:etutor/features/test_series/provider/test_series_provider.dart';
import 'package:etutor/features/test_series/widgets/attended_test_shimmer.dart';
import 'package:etutor/features/test_series/widgets/notestseries.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/test_series/widgets/test_series_card.dart';
import 'package:provider/provider.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();

  @override
  void initState() {
    super.initState();
    _fetchUpcomingTests();
  }

  Future<void> _fetchUpcomingTests() async {
    await context.read<TestSeriesProvider>().fetchUpcomingTests(context);
  }

  @override
  Widget build(BuildContext context) {
    testSeriesProvider = Provider.of<TestSeriesProvider>(context, listen: true);

    return testSeriesProvider.isUpcomingTestsLoading
    ? AttendedTestShimmer()
    : testSeriesProvider.upcomingTests.isEmpty
      ? const noTestSeries()

    : ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: testSeriesProvider.upcomingTests.length,
      itemBuilder: (context, index) {
        final test = testSeriesProvider.upcomingTests[index];
        return TestSeriesCard(
          title: test.name ?? "",
          date: test.startTime ?? "",
          startTime: test.startTime ?? "",
          endTime: test.endTime ?? "",
          duration: test.totalDuration.toString(),
          marks: test.totalMarks.toString(),
          questionCount: test.questionsCount.toString(),
          isUpcoming: true,
        );
      },
    );
  }
}
