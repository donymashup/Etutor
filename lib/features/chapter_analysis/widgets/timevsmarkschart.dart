import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TimeVsMarksChart extends StatelessWidget {
  final List<double> marks; 
  final List<double> times; 

  const TimeVsMarksChart({
    super.key,
    required this.marks,
    required this.times,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, 
      child: SizedBox(
        width: 400, 
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 10),
            child: Text(
              "Time v/s Marks",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
            const SizedBox(height: 10),
            Expanded(
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100, 
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${value.toInt()}%",
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final categories = ["Correct", "Wrong", "Unans"];
                          if (value.toInt() < 0 || value.toInt() >= categories.length) {
                            return const SizedBox();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              categories[value.toInt()],
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black12),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        marks.length,
                        (index) => FlSpot(index.toDouble(), marks[index]),
                      ),
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blueAccent,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, _, __, ___) {
                          if (spot.x == 0) {
                            return FlDotCirclePainter(color: Colors.green, radius: 5);
                          } else if (spot.x == 1) {
                            return FlDotCirclePainter(color: Colors.red, radius: 5);
                          } else {
                            return FlDotCirclePainter(color: Colors.orange, radius: 5);
                          }
                        },
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipMargin: 8,
                      getTooltipItems: (spots) {
                        final categories = ["Correct", "Wrong", "Unans"];
                        return spots.map((spot) {
                          String category = categories[spot.x.toInt()];
                          return LineTooltipItem(
                            "$category\nMarks: ${spot.y.toInt()}%\nTime: ${times[spot.x.toInt()].toStringAsFixed(1)} sec",
                            const TextStyle(color: Colors.black, fontSize: 12),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 🔹 Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LegendItem(color: Colors.green, text: "Correct"),
                SizedBox(width: 10),
                LegendItem(color: Colors.red, text: "Wrong"),
                SizedBox(width: 10),
                LegendItem(color: Colors.orange, text: "Unanswered"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
