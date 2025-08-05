import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:etutor/features/profile/screens/edit_profile.dart';
import 'package:etutor/features/profile/widgets/custom_wave_painter.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails.data;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: userDetails == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: [
                  CustomPaint(
                    painter: CustomWavePainter(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      insetPadding: const EdgeInsets.all(10),
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: InteractiveViewer(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: userDetails.image != null &&
                                                    userDetails
                                                        .image!.isNotEmpty
                                                ? Image.network(
                                                    userDetails.image!,
                                                    fit: BoxFit.contain,
                                                  )
                                                : Image.asset(
                                                    "assets/images/default_user_image.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: userDetails.image != null &&
                                          userDetails.image!.isNotEmpty
                                      ? Image.network(
                                          userDetails.image!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/default_profile.png",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                       "${userDetails.firstName ?? ''} ${userDetails.lastName ?? ''}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                       " ${userDetails.qualification ?? ''}",
                                      style: TextStyle(
                                          color: AppColor.greyText, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            // const Spacer(),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EditProfile(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit_note_rounded,
                                    size: 26),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(Icons.person,
                                "${userDetails.firstName ?? ''} ${userDetails.lastName ?? ''}"),
                            _buildInfoRow(Icons.phone_android,
                                userDetails.phone ?? 'N/A'),
                            _buildInfoRow(
                                Icons.location_on,
                                [
                                  userDetails.parsedAddress,
                                  userDetails.state,
                                  userDetails.zipCode,
                                  userDetails.parsedCountry
                                ].where((e) => e.trim().isNotEmpty).join(", ")),
                            _buildInfoRow(
                                Icons.email, userDetails.email ?? 'N/A'),
                            _buildInfoRow(Icons.cake, userDetails.dob ?? 'N/A'),
                            _buildInfoRow(Icons.class_rounded,
                                "${userDetails.syllabus ?? ''} Standard"),
                            _buildInfoRow(
                                Icons.school, userDetails.school ?? 'N/A'),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColor.greyStroke),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                _buildActionButton(
                                    text: "Delete Account",
                                    color: AppColor.primaryColor,
                                    onPressed: () {
                                      // handle delete
                                    }),
                                const SizedBox(height: 10),
                                _buildActionButton(
                                  text: "Log out",
                                  color: AppColor.secondaryColor,
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text(
                                          "Are you sure you want to log out?",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog

                                              // Call logout from provider
                                              await Provider.of<LoginProvider>(
                                                      context,
                                                      listen: false)
                                                  .logout();

                                              // Navigate to LoginScreen
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const PhoneNumberAuth()),
                                                (route) => false,
                                              );
                                            },
                                            child: const Text("Log Out"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Icon(icon, color: AppColor.primaryColor),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      {required String text,
      required Color color,
      required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: onPressed,
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
