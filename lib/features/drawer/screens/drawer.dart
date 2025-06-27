import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/drawer/widgets/drawer_item.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          // Top White Section
          Container(
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
              ),
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png", // replace with your actual logo
                  height: 60,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Dedicated. Real. Marvellous.",
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Blue Section
          Expanded(
            child: Container(
              color: AppColor.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ListView(
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage:
                            AssetImage('assets/images/smriti1.jpeg'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hollo Yukihira",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "INK3322",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const DrawerItem(
                    icon: Icons.edit,
                    title: "Edit Profile",
                  ),
                  const DrawerItem(
                      icon: Icons.notifications, title: "Notifications"),
                  const DrawerItem(
                      icon: Icons.help_outline, title: "Help & Support"),
                  const DrawerItem(
                      icon: Icons.policy, title: "Terms & Conditions"),
                  const DrawerItem(icon: Icons.info_outline, title: "About us"),
                   DrawerItem(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:
                              const Text("Are you sure you want to log out?",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Add your logout logic here
                              },
                              child: const Text("Log Out"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
