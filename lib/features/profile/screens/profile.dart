import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:etutor/features/profile/screens/edit_profile.dart';
import 'package:etutor/features/profile/widgets/custom_wave_painter.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDetailsProvider>(context);
    final userDetails = userProvider.userDetails.data;

    String? qualification = context
        .read<LoginProvider>()
        .getClassNameById(userDetails?.qualification);
    String? syllabus =
        context.read<LoginProvider>().getSyllabusNameById(userDetails?.syllabus ?? '');

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
                                            child: _buildProfileImage(
                                                userDetails.image, 200),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: _buildProfileImage(
                                    userDetails.image,
                                    100,
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
                                      qualification ?? "N/A",
                                      style: TextStyle(
                                          color: AppColor.greyText,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfile(),
                                    ),
                                  );
                                  // Refresh after returning from Edit Profile
                                  await Provider.of<UserDetailsProvider>(
                                          context,
                                          listen: false)
                                      .refreshUserDetails(context);
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
                                Icons.email, userDetails.email ?? 'N/A'),
                            _buildInfoRow(Icons.cake,
                                convertDateFormat(userDetails.dob ?? 'N/A')),
                            _buildInfoRow(Icons.class_rounded,
                                syllabus ?? "N/A"),
                            _buildInfoRow(
                                Icons.school, userDetails.school ?? 'N/A'),
                          ],
                        ),
                        const SizedBox(height: 30),
                        _buildActions(context),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  /// Builds profile image with shimmer placeholder
  Widget _buildProfileImage(String? imageUrl, double size) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: size,
            height: size,
            color: Colors.grey,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/default_profile.png",
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Image.asset(
        "assets/images/default_profile.png",
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }
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

  Widget _buildActions(BuildContext context) {
    return Container(
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
              },
            ),
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
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();

                          await Provider.of<LoginProvider>(context,
                                  listen: false)
                              .logout();

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
                borderRadius: BorderRadius.circular(5)),
          ),
          onPressed: onPressed,
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  String convertDateFormat(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat('dd-MM-yyyy').format(date);
      return formattedDate;
    } catch (e) {
      return dateString;
    }
  }
}
