import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(
        title,
        style: const TextStyle(color: AppColor.primaryColor),
      ),
      onTap: onTap,
    );
  }
}
