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
  final String questionCount;
  final VoidCallback? onReview;
  final bool isOngoing;
  final bool isUpcoming;

  const TestSeriesCard({
    super.key,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.marks,
    required this.questionCount,
    this.onReview,
    this.isOngoing = false,
    this.isUpcoming = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isOngoing
        ? AppColor.secondaryColor
        : isUpcoming
            ? const Color(0xFFB2E6C2)
            : AppColor.primaryColor;

    final IconData leadingIcon = isOngoing
        ? Icons.assignment_outlined
        : isUpcoming
            ? Icons.access_time
            : Icons.check_circle_outline;

    final Color iconBgColor = isOngoing
        ? const Color(0xFFFFF1E6)
        : isUpcoming
            ? const Color(0xFFE6F0FB)
            : const Color(0xFFE6F0FB);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DottedBorder(
        color: borderColor,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: iconBgColor,
                    child: Icon(
                      leadingIcon,
                      color: AppColor.primaryColor,
                    ),
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
                  if (!isUpcoming)
                    OutlinedButton(
                      onPressed: onReview,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.primaryColor,
                        side: BorderSide(color: AppColor.primaryColor),
                        backgroundColor: isOngoing
                            ? AppColor.primaryColor.withOpacity(0.1)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                      ),
                      child: Text(
                        isOngoing ? "Attend" : "Review",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),

              const Divider(height: 24, thickness: 1),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconLabelValue(Icons.access_time, "Start", startTime),
                  _iconLabelValue(Icons.access_time, "End", endTime),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconLabelValue(Icons.hourglass_bottom, "Duration", duration),
                  _iconLabelValue(
                    isOngoing ? Icons.help_outline : Icons.flag_outlined,
                    isOngoing ? "Questions" : "Marks",
                    isOngoing ? questionCount : marks,
                  ),
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
