import 'package:etutor/features/test_series/provider/test_series_provider.dart';
import 'package:etutor/features/test_series/screens/attented_testseries_report.dart';
import 'package:etutor/features/test_series/widgets/attended_test_shimmer.dart';
import 'package:etutor/features/test_series/widgets/notestseries.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/test_series/widgets/test_series_card.dart';
import 'package:provider/provider.dart';

class AttendedPage extends StatefulWidget {
  const AttendedPage({super.key});

  @override
  State<AttendedPage> createState() => _AttendedPageState();
}

class _AttendedPageState extends State<AttendedPage> {
  TestSeriesProvider testSeriesProvider = TestSeriesProvider();

  @override
  void initState() {
    super.initState();
    _fetchAttendedTests();
  }

  Future<void> _fetchAttendedTests() async {
    final attendedTestSeriesProvider = context.read<TestSeriesProvider>();
    await attendedTestSeriesProvider.fetchAttendedTests(context);
  }

  @override
  Widget build(BuildContext context) {
    testSeriesProvider = Provider.of<TestSeriesProvider>(context, listen: true);

    return testSeriesProvider.isAttendedTestsLoading
        ? AttendedTestShimmer()
        : testSeriesProvider.attendedTests.isEmpty
            ? noTestSeries()
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: testSeriesProvider.attendedTests.length,
                itemBuilder: (context, index) {
                  final test = testSeriesProvider.attendedTests[index];
                  return TestSeriesCard(
                    title: test.name ?? "Sample Test",
                    date: test.subTime ?? "...",
                    startTime: test.start ?? "...",
                    endTime: "...",
                    duration: "duration",
                    marks: "marks",
                    questionCount: "questions",
                    onReview: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TestReportPage(testid:test.testid ?? " " )));
                      // Handle review tap
                    },
                    isAttended: true,
                  );
                },
              );
  }
}
