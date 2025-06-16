import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const CategoryButton({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120, // 🔼 Increased width
      height: 70, // 🔽 Reduced height
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor().primaryColor, width: 1), // 🔼 Changed border color
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.grey, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


class CategoryButtonList extends StatelessWidget {
  const CategoryButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: const [
            CategoryButton(label: 'Design', icon: Icons.draw),
            CategoryButton(label: 'Coding', icon: Icons.code),
            CategoryButton(label: 'UI/UX', icon: Icons.design_services),
            CategoryButton(label: 'Marketing', icon: Icons.campaign),
            CategoryButton(label: 'Finance', icon: Icons.money),
            CategoryButton(label: 'Music', icon: Icons.music_note),
            CategoryButton(label: 'Health', icon: Icons.health_and_safety),
          ],
        ),
      ),
    );
  }
}
