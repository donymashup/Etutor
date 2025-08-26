import 'package:etutor/features/test_series/provider/test_series_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:fl_chart/fl_chart.dart';

/// ✅ Main Report Page
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
        title: const Text("Test Performance Report"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderCard(report),
            const SizedBox(height: 20),
            _buildStatsGrid(report),
            const SizedBox(height: 20),
            _buildScoreAnalysisChart(report), // ✅ Donut Chart
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

  /// --- HEADER CARD ---
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
                      : Colors.red.shade400,
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

  /// --- SCORE ANALYSIS DONUT CHART ---
  Widget _buildScoreAnalysisChart(report) {
    final correct = report.userDetails?.correctlyAnswered ?? 0;
    final incorrect = report.userDetails?.incorrectlyAnswered ?? 0;
    final unattempted = report.userDetails?.questionsUnAnswered ?? 0;
    final unattended = report.userDetails?.questionsUnAttended ?? 0;

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
            height: 180,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 55,
                sectionsSpace: 2,
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
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: const [
              _LegendItem(color: Colors.green, text: "Correct"),
              _LegendItem(color: Colors.red, text: "Incorrect"),
              _LegendItem(color: Colors.blue, text: "Unanswered"),
              _LegendItem(color: Colors.grey, text: "Unattended"),
            ],
          ),
        ],
      ),
    );
  }

  /// --- STATS GRID ---
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
        childAspectRatio: 2.4,
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

/// --- LEGEND ITEM WIDGET ---
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
