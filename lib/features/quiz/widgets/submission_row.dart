import 'package:flutter/material.dart';

class SubmissionRow extends StatelessWidget {
  final String label;
  final  String count;
  final IconData icon;
  const SubmissionRow(this.label, this.count, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(label),
            ],
          ),
          Text(count, style: TextStyle(fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}
