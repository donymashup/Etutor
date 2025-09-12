import 'package:etutor/common/constants/app_constants.dart' show AppColor;
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/test_series/model/test_performance_model.dart';
import 'package:etutor/features/test_series/provider/test_series_provider.dart';
import 'package:etutor/features/test_series/screens/view_solutions_tests.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fl_chart/fl_chart.dart';

class TestReportPage extends StatefulWidget {
  final String testid;
  const TestReportPage({super.key, required this.testid});

  @override
  State<TestReportPage> createState() => _TestReportPageState();
}

class _TestReportPageState extends State<TestReportPage> {
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await context.read<TestSeriesProvider>().fetchTestReports(
          context: context,
          testid: widget.testid,
          type: "mains",
        );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TestSeriesProvider>();

    if (provider.isLoadingtestreport) {
      return Scaffold(
        appBar: AppBar(title: const Text("Test Performance Report")),
        body: _buildShimmerLoader(),
      );
    }

    final report = provider.testReports;
    if (report == null) {
      return const Scaffold(
        body: Center(child: Text("No report found")),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: const Text(
          "Test Performance Report",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ViewSolutionsTests(testId: widget.testid),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "View Solution",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildHeaderCard(report),
            const SizedBox(height: 20),
            _buildStatsGrid(report),
            const SizedBox(height: 20),
            _buildScoreAnalysisChart(report), //  Donut Chart
            const SizedBox(height: 20),
            _buildSubjectVsTimeChart(report), //  Subject vs Time Chart
            const SizedBox(height: 20),
            _buildPerformanceSummary(report), //  Performance Summary
            const SizedBox(height: 20),
            _buildSubjectWiseScoreAnalysis(report), // Subject-wise score
          ],
        ),
      ),
    );
  }

  /// --- SHIMMER LOADER ---
  Widget _buildShimmerLoader() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ///  Header Card
  Widget _buildHeaderCard(report) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade400, Colors.indigo.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade200.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.examDetails?.title ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.white70, size: 18),
                  const SizedBox(width: 6),
                  Text("Duration: ${report.examDetails?.duration ?? "0"} min",
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.calendar_today, color: Colors.white70, size: 18),
                  SizedBox(width: 6),
                  Text("2025-03-23", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.help_outline,
                      color: Colors.white70, size: 18),
                  const SizedBox(width: 6),
                  Text("Total Qs: ${report.examDetails?.totalQuestions ?? 0}",
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (report.userDetails?.result == "Passed")
                      ? Colors.green.shade400
                      : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Result: ${report.userDetails?.result ?? "N/A"}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Score Analysis Donut Chart
  Widget _buildScoreAnalysisChart(report) {
    final correct = report.userDetails?.correctlyAnswered ?? 0;
    final incorrect = report.userDetails?.incorrectlyAnswered ?? 0;
    final unattempted = report.userDetails?.questionsUnAnswered ?? 0;
    final unattended = report.userDetails?.questionsUnAttended ?? 0;

    int? touchedIndex;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text("Score Analysis",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        centerSpaceRadius: 55,
                        sectionsSpace: 2,
                        pieTouchData: PieTouchData(
                          touchCallback: (event, response) {
                            if (!event.isInterestedForInteractions ||
                                response == null ||
                                response.touchedSection == null) {
                              setState(() => touchedIndex = -1);
                              return;
                            }
                            setState(() {
                              touchedIndex =
                                  response.touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: correct.toDouble(),
                            title: "",
                            radius: 22,
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: incorrect.toDouble(),
                            title: "",
                            radius: 22,
                          ),
                          PieChartSectionData(
                            color: Colors.blue,
                            value: unattempted.toDouble(),
                            title: "",
                            radius: 22,
                          ),
                          PieChartSectionData(
                            color: Colors.grey,
                            value: unattended.toDouble(),
                            title: "",
                            radius: 22,
                          ),
                        ],
                      ),
                    ),
                    if (touchedIndex != null && touchedIndex! >= 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getLabel(touchedIndex!, correct, incorrect,
                              unattempted, unattended),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                children: const [
                  _LegendItem(color: Colors.green, text: "Correct"),
                  _LegendItem(color: Colors.red, text: "Incorrect"),
                  _LegendItem(color: Colors.blue, text: "Unattempted"),
                  _LegendItem(color: Colors.grey, text: "Unattended"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  //Subject Vs Time
  /// Subject Vs Time (Horizontal Scroll)
  Widget _buildSubjectVsTimeChart(report) {
    final subjects = report.subjectAnalysis ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Subject Vs Time",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 330, // enough for chart + legend
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final s = subjects[index];

              return Container(
                width: 260,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    /// Subject title
                    Text(
                      s.title ?? "Subject",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Chart
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100,
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) => Text(
                                  "${value.toInt()}%",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(
                                toY: s.count.perCorrect,
                                color: Colors.green,
                                width: 18,
                              ),
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(
                                toY: s.count.perIncorrect,
                                color: Colors.red,
                                width: 18,
                              ),
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(
                                toY: s.count.perUnattempted,
                                color: Colors.blue,
                                width: 18,
                              ),
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(
                                toY: s.count.perUnattended,
                                color: Colors.grey,
                                width: 18,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Legend
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      children: const [
                        _LegendItem(color: Colors.green, text: "Correct"),
                        _LegendItem(color: Colors.red, text: "Incorrect"),
                        _LegendItem(color: Colors.blue, text: "Unattempted"),
                        _LegendItem(color: Colors.grey, text: "Unattended"),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //Performance Summary
  Widget _buildPerformanceSummary(report) {
    final time = report.time;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Performance Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _summaryBox([
            "Total Number of Correctly Answered: ${report.userDetails?.correctlyAnswered ?? 0}",
            "Total Time Taken: ${time.totalTimeTaken} sec",
            "Total Number of Incorrectly Answered: ${report.userDetails?.incorrectlyAnswered ?? 0}",
            "Average Time Spent on Correctly Answered: ${time.avgCorrect} sec",
          ]),
          const SizedBox(height: 16),
          _summaryBox([
            "Total Number of Un-attempted Questions: ${report.userDetails?.questionsUnAnswered ?? 0}",
            "Average Time Spent on Incorrectly Answered: ${time.avgIncorrect} sec",
            "Total Number of Un-attended Questions: ${report.userDetails?.questionsUnAttended ?? 0}",
            "Average Time Spent on Un-attempted: ${time.avgUnanswered} sec",
          ]),
        ],
      ),
    );
  }

  /// --- SUBJECT / SECTION WISE SCORE ANALYSIS ---
  Widget _buildSubjectWiseScoreAnalysis(ExamPerformanceModel report) {
    final subjects = report.subjectAnalysis ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Subject / Section Wise Score Analysis",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 330, // ✅ Extra space for chart + legend
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];

              return Container(
                width: 240,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// ✅ Subject Name
                    Text(
                      subject.title ?? "Subject",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// ✅ Donut chart
                    SizedBox(
                      height: 160,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 45,
                          sectionsSpace: 2,
                          sections: [
                            PieChartSectionData(
                              value: subject.count.perCorrect.toDouble(),
                              color: Colors.green,
                              title: subject.count.perCorrect > 0
                                  ? "${subject.count.perCorrect}%"
                                  : "",
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: subject.count.perIncorrect.toDouble(),
                              color: Colors.red,
                              title: subject.count.perIncorrect > 0
                                  ? "${subject.count.perIncorrect}%"
                                  : "",
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: subject.count.perUnattempted.toDouble(),
                              color: Colors.blue,
                              title: subject.count.perUnattempted > 0
                                  ? "${subject.count.perUnattempted}%"
                                  : "",
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: subject.count.perUnattended.toDouble(),
                              color: Colors.grey,
                              title: subject.count.perUnattended > 0
                                  ? "${subject.count.perUnattended}%"
                                  : "",
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ✅ Legend neatly placed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _LegendItem(color: Colors.green, text: "Correct"),
                        _LegendItem(color: Colors.red, text: "Incorrect"),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _LegendItem(color: Colors.blue, text: "Unattempted"),
                        _LegendItem(color: Colors.grey, text: "Unattended"),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// --- Subject Card with Donut Chart ---
  Widget _subjectCard(subject) {
    final correct = subject.correct ?? 0;
    final incorrect = subject.incorrect ?? 0;
    final unattempted = subject.unattempted ?? 0;
    final unattended = subject.unattended ?? 0;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subject.name ?? "Subject",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          // ✅ Donut Chart
          SizedBox(
            height: 160,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    value: correct.toDouble(),
                    color: Colors.green,
                    title: correct > 0 ? "Correct\n$correct" : "",
                    radius: 40,
                    titleStyle:
                        const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  PieChartSectionData(
                    value: incorrect.toDouble(),
                    color: Colors.red,
                    title: incorrect > 0 ? "Incorrect\n$incorrect" : "",
                    radius: 40,
                    titleStyle:
                        const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  PieChartSectionData(
                    value: unattempted.toDouble(),
                    color: Colors.blue,
                    title: unattempted > 0 ? "Unattempted\n$unattempted" : "",
                    radius: 40,
                    titleStyle:
                        const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  PieChartSectionData(
                    value: unattended.toDouble(),
                    color: Colors.grey,
                    title: unattended > 0 ? "Unattended\n$unattended" : "",
                    radius: 40,
                    titleStyle:
                        const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: const [
              _LegendItem(color: Colors.green, text: "Correct"),
              _LegendItem(color: Colors.red, text: "Incorrect"),
              _LegendItem(color: Colors.blue, text: "Unattempted"),
              _LegendItem(color: Colors.grey, text: "Unattended"),
            ],
          ),
        ],
      ),
    );
  }

  //Legend Item
  static Widget _legendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  // Helper Widget for box
  Widget _summaryBox(List<String> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(e, style: const TextStyle(fontSize: 14)),
                ))
            .toList(),
      ),
    );
  }

  // Helper for labels
  String _getLabel(
      int index, int correct, int incorrect, int unattempted, int unattended) {
    switch (index) {
      case 0:
        return "Correct: $correct";
      case 1:
        return "Incorrect: $incorrect";
      case 2:
        return "Unattempted: $unattempted";
      case 3:
        return "Unattended: $unattended";
      default:
        return "";
    }
  }

  // STATS GRID
  Widget _buildStatsGrid(report) {
    final stats = [
      {
        "title": "Score",
        "value":
            "${report.userDetails?.score ?? 0}/${report.examDetails?.maxMark ?? 0}",
        "color": Colors.red,
        "icon": Icons.star
      },
      {
        "title": "Avg Time",
        "value": "${report.userDetails?.averageTime ?? 0}s",
        "color": Colors.blue,
        "icon": Icons.timer
      },
      {
        "title": "Accuracy",
        "value": "${report.userDetails?.accuracy ?? 0}%",
        "color": Colors.orange,
        "icon": Icons.bolt
      },
      {
        "title": "Rank",
        "value": "${report.userDetails?.rank ?? "-"}",
        "color": Colors.purple,
        "icon": Icons.leaderboard
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          decoration: BoxDecoration(
            color: (stat["color"] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: stat["color"] as Color,
                child: Icon(stat["icon"] as IconData, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(stat["title"] as String,
                      style: const TextStyle(fontSize: 12)),
                  Text(stat["value"] as String,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//LEGEND ITEM WIDGET
class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
