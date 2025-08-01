import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/profile/screens/edit_profile.dart';
import 'package:etutor/features/drawer/screens/about_us.dart';
import 'package:etutor/features/drawer/screens/privacy_policy.dart';
import 'package:etutor/features/drawer/screens/terms&conditions.dart';
import 'package:etutor/features/profile/screens/profile.dart';
import 'package:etutor/features/wallet/screen/dream_coins.dart';
import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/drawer/widgets/drawer_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails.data;

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
                  "assets/images/dreamthemlogo.png",
                  height: 60,
                ),
                const SizedBox(height: 12),
                const Text(
                  "reach.direct.mould.",
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColor.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundImage: userDetails?.image != null &&
                                  userDetails!.image!.isNotEmpty
                              ? NetworkImage(userDetails.image!)
                              : const AssetImage(
                                      'assets/images/default_user_image.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userDetails?.firstName ?? 'No Name',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userDetails?.email ?? 'No Email',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  DrawerItem(
                    icon: FontAwesomeIcons.coins,
                    title: "Dream Coins",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DreamCoins()),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.edit,
                    title: "Edit Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.notifications,
                    title: "About Us",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutUsScreen()),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.help_outline,
                    title: "Terms & Conditions",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen()),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.policy,
                    title: "Privacy Policy",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicyScreen()),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.info_outline,
                    title: "Help & Support",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Help & Support"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Phone: +91 8113813377"),
                              SizedBox(height: 8),
                              Text("Email: pskeduventures@gmail.com"),
                            ],
                          ),
                          actions: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("OK"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.delete,
                    title: "Delete Account",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                              "Are you sure you want to delete your account?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          content: const Text("This action cannot be undone."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.logout,
                    title: "Logout Account",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Are you sure you want to log out?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop(); // Close the dialog

                                // Call logout function from LoginProvider
                                await Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .logout();

                                // Navigate to LoginScreen and clear back stack
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => const PhoneNumberAuth()),
                                  (route) => false,
                                );
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
