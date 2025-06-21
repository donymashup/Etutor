import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyProgress extends StatelessWidget {
  const WeeklyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.6,
      child: BarChart(
        BarChartData(
          barGroups: [
            _makeBarGroup(0, 400, 250),
            _makeBarGroup(1, 220, 100),
            _makeBarGroup(2, 350, 270),
            _makeBarGroup(3, 370, 350),
            _makeBarGroup(4, 30, 230),
            _makeBarGroup(5, 300, 240),
            _makeBarGroup(6, 290, 310),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const days = [
                    'Sat',
                    'Sun',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri'
                  ];
                  return Text(
                    days[value.toInt()],
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true, drawVerticalLine: true, verticalInterval: null),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: false),
          groupsSpace: 12,
        ),
      ),
    );
  }
  
  BarChartGroupData _makeBarGroup(int x, double correct, double wrong) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: correct,
        width: 8,
        color: Colors.blue.shade800,
        borderRadius: BorderRadius.circular(4),
      ),
      BarChartRodData(
        toY: wrong,
        width: 8,
        color: Colors.orange.shade600,
        borderRadius: BorderRadius.circular(4),
      ),
    ]);
  }
}