import 'package:etutor/features/test_series/provider/test_series_provider.dart';
import 'package:etutor/features/test_series/widgets/attended_test_shimmer.dart';
import 'package:etutor/features/test_series/widgets/notestseries.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/test_series/widgets/test_series_card.dart';
import 'package:provider/provider.dart';

class OngoingPage extends StatefulWidget {
  const OngoingPage({super.key});

  @override
  State<OngoingPage> createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();

  @override
  void initState() {
    super.initState();
    _fetchOngoingTests();
  }

  Future<void> _fetchOngoingTests() async {
    final ongoingTestSeriesProvider = context.read<TestSeriesProvider>();
    await ongoingTestSeriesProvider.fetchOngoingTests(context);
  }

  @override
  Widget build(BuildContext context) {
    testSeriesProvider = Provider.of<TestSeriesProvider>(context, listen: true);

    // if (ongoingTests.isEmpty) {
    //   return const noTestSeries();
    // }

    return testSeriesProvider.isOngoingTestsLoading
        ? AttendedTestShimmer()
        : testSeriesProvider.ongoingTests.isEmpty
            ? noTestSeries()
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: testSeriesProvider.ongoingTests.length,
                itemBuilder: (context, index) {
                  final test = testSeriesProvider.ongoingTests[index];
                  return TestSeriesCard(
                    title: test.name ?? "",
                    date: test.startTime ?? "",
                    startTime: test.startTime ?? "",
                    endTime: test.endTime ?? "",
                    duration: test.totalDuration.toString(),
                    marks: "",
                    questionCount: test.questionsCount.toString(),
                    onReview: () {
                      // Handle attend/review action
                    },
                    isOngoing: true,
                  );
                },
              );
  }
}
