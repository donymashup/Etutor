import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/screen/password_reset_otp.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/arrow_topLeft.png"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Don’t worry, it happens to the best of us",
                    style: TextStyle(
                      color: AppColor.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // WhiteStrokeTextField(
                  //   hind: "Enter your Mobile number",
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  whiteButton(
                    text: "Continue",
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>PasswordResetOtp()));
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/arrow_bottomright.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}