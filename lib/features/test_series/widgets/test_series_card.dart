import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:etutor/common/constants/app_constants.dart';

class TestSeriesCard extends StatelessWidget {
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final String duration;
  final String marks;
  final VoidCallback onReview;

  const TestSeriesCard({
    super.key,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.marks,
    required this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DottedBorder(
        color: AppColor.lightNightBlue,
        strokeWidth: 1.5,
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        dashPattern: const [6, 3],
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Row: Icon + Title + Date + Review Button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFFE6F0FB),
                    child: Icon(Icons.check_circle_outline,
                        color: AppColor.primaryColor),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                        const SizedBox(height: 2),
                        Text(date,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            )),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: onReview,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColor.primaryColor,
                      side: const BorderSide(color: AppColor.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                    ),
                    child: const Text("Review",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                ],
              ),

              const Divider(height: 24, thickness: 1),

              /// Row: Start & End
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconLabelValue(Icons.access_time, "Start", startTime),
                  _iconLabelValue(Icons.access_time, "End", endTime),
                ],
              ),
              const SizedBox(height: 12),

              /// Row: Duration & Marks
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconLabelValue(
                      Icons.hourglass_bottom, "Duration", duration),
                  _iconLabelValue(Icons.flag_outlined, "Marks", marks),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconLabelValue(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
