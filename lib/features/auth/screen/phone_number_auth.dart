import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/screen/password_screen.dart';
import 'package:etutor/features/auth/screen/registration.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:etutor/features/auth/widgets/whitestroke_textfield.dart';
import 'package:flutter/material.dart';

class PhoneNumberAuth extends StatelessWidget {
  const PhoneNumberAuth({super.key});

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
                    "Welcome Learner!",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  Text(
                    "Enter your mobile number to get started ",
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WhiteStrokeTextField(
                    hind: "Enter your Mobile number",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onLongPress: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Registration()));
                    },
                    child: whiteButton(
                      text: "Verify Phone Number",
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PasswordScreen()));
                      },
                    ),
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
