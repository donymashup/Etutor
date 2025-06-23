import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyProgress extends StatelessWidget {
  const MonthlyProgress({super.key});

  @override
  Widget build(BuildContext context) {
   return SizedBox(
      height: MediaQuery.of(context).size.width * 0.6,
      width: MediaQuery.of(context).size.width - 60,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const months = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan'];
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 12, color: Colors.orange),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 32),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 20),
                FlSpot(1, 30),
                FlSpot(2, 40),
                FlSpot(3, 70),
                FlSpot(4, 30),
                FlSpot(5, 50),
                FlSpot(6, 20),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade800,
                  Colors.blue.shade400,
                ],
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade800.withOpacity(0.3),
                    Colors.blue.shade100.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: false),
              barWidth: 4,
            )
          ],
        ),
      ),
    );
  }
}