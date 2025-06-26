import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const DrawerItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(
        title,
        style: const TextStyle(color: AppColor.primaryColor),
      ),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        // Add page navigation if needed
      },
    );
  }
}
