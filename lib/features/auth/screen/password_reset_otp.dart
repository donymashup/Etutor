import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/password_reset_screen.dart';
import 'package:etutor/features/auth/widgets/pinput_theme.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class PasswordResetOtp extends StatefulWidget {
  final String code;
  final String phone;
  const PasswordResetOtp({super.key, required this.code, required this.phone});

  @override
  State<PasswordResetOtp> createState() => _PasswordResetOtpState();
}

class _PasswordResetOtpState extends State<PasswordResetOtp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginProvider>().sendOtpForgotPassword(
            context,
            widget.phone,
            widget.code, 
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
    final TextEditingController otpController = TextEditingController();
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
                    "Check Your Phone",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "We just sent an OTP to your mobile number\n+91 9994499449",
                    style: TextStyle(
                      color: AppColor.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Pinput(
                    length: 6,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: defaultPinTheme,
                    validator: (value) {
                      if (value == null || value.length != 6) {
                        return 'Invalid OTP';
                      }
                      return null;
                    },
                    onCompleted: (pin) {
                      if (pin == loginProvider.forgototp.toString()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PasswordResetScreen()),
                        );
                      } else {
                        showSnackbar(context, "Incorrect OTP");
                      }
                    },
                    showCursor: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  whiteButton(
                    text: "Login",
                    onpressed: () {
                      otpController.text == loginProvider.forgototp
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PasswordResetScreen()))
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "Didn’t receive an OTP?",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.whiteColor,
                              fontFamily: 'Poppins',
                            )),
                        TextSpan(
                            text: "Send Again",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.secondaryColor,
                              fontFamily: 'Poppins',
                            ))
                      ]))
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
