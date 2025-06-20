
import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selected ? AppColor.primaryColor.withOpacity(0.1) : Colors.transparent,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? AppColor.primaryColor : AppColor.greyText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
