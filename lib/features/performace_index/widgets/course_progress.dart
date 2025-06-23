import 'package:flutter/material.dart';

class CategoryProgressChart extends StatefulWidget {
  const CategoryProgressChart({super.key});

  @override
  State<CategoryProgressChart> createState() => _CategoryProgressChartState();
}

class _CategoryProgressChartState extends State<CategoryProgressChart> {
  String selectedCourse = 'Mental Ability';

  final Map<String, List<double>> courseData = {
    'Mental Ability': [0.85, 0.55, 0.45],
    'Critical Thinking': [0.65, 0.35, 0.75],
  };

  @override
  Widget build(BuildContext context) {
    final progressValues = courseData[selectedCourse]!;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Container(
        key: ValueKey(selectedCourse), // triggers rebuild on change
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting course
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedCourse,
                  underline: const SizedBox(),
                  items: courseData.keys.map((course) {
                    return DropdownMenuItem(
                      value: course,
                      child: Text(
                        course,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null && value != selectedCourse) {
                      setState(() {
                        selectedCourse = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildProgressRow("Videos", progressValues[0]),
            const SizedBox(height: 12),
            _buildProgressRow("Materials", progressValues[1]),
            const SizedBox(height: 12),
            _buildProgressRow("Tests", progressValues[2]),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow(String label, double value) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(color: Colors.orange, fontSize: 14),
          ),
        ),
        Expanded(
          child: Container(
            height: 18,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: value * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
