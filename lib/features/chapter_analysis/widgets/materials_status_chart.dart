import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MaterialsStatusChart extends StatelessWidget {
  final int materialstotal;
  final int materialswatched;

  const MaterialsStatusChart({
    super.key,
    required this.materialstotal,
    required this.materialswatched,
  });

  @override
  Widget build(BuildContext context) {
    final watched = materialswatched;
    final total = materialstotal;
    final pending = total - watched;
    final percentage = total > 0 ? (watched / total * 100).round() : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 10),
          child: Text(
            "Materials Status",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              // Semi-circle Chart
              SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        startDegreeOffset: 180,
                        sectionsSpace: 2,
                        centerSpaceRadius: 50,
                        sections: [
                          PieChartSectionData(
                            value: watched.toDouble(),
                            color: Colors.blue[800],
                            radius: 30,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            value: pending.toDouble(),
                            color: Colors.orange,
                            radius: 30,
                            showTitle: false,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$percentage%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),

              // Right-side Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total No. of Materials : $total',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    _statusRow(Colors.blue[800]!, 'Watched', watched),
                    const SizedBox(height: 8),
                    _statusRow(Colors.orange, 'Pending', pending),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusRow(Color color, String label, int count) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$label :",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            "$count",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
