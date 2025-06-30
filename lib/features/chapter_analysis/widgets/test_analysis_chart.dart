import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TestAnalysisChart extends StatelessWidget {
  const TestAnalysisChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 10),
          child: Text(
            "Test Analysis",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              maxY: 14,
              barTouchData: BarTouchData(enabled: false),
              gridData: FlGridData(show: true, drawHorizontalLine: true),
              borderData: FlBorderData(show: false),
              alignment: BarChartAlignment.spaceAround,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      switch (value.toInt()) {
                        case 0:
                          return const Text("Correct");
                        case 1:
                          return const Text("Wrong");
                        case 2:
                          return const Text("Unanswered");
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: [
                _makeGroup(0, 3, Colors.orange), // Unanswered
                _makeGroup(1, 5, Colors.green), // Correct
                _makeGroup(2, 12, Colors.red), // Wrong
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Legend
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _LegendItem(color: Colors.green, text: "Correct"),
              _LegendItem(color: Colors.red, text: "Wrong"),
              _LegendItem(color: Colors.orange, text: "Unanswered"),
            ],
          ),
        ),
      ],
    );
  }

  BarChartGroupData _makeGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 30,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          rodStackItems: [],
        ),
      ],
      showingTooltipIndicators: [0],
      barsSpace: 4,
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
