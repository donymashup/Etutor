import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/auth/screen/forgot_password.dart';
import 'package:etutor/features/auth/screen/registration.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:etutor/features/auth/widgets/whitestroke_textfield.dart';
import 'package:etutor/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

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
                  Image.asset("assets/images/dreamthemlogo.png"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Enter your password to continue learning",
                    style: TextStyle(
                      color: AppColor.whiteColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WhiteStrokeTextField(
                    hind: "Enter your Password",
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  whiteButton(
                    text: "Login",
                    onpressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBarScreen()));
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                             Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                          },
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.whiteColor,
                              )))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
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
