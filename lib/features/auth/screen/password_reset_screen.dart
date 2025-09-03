import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/password_reset_succesfull.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:etutor/features/auth/widgets/whitestroke_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatefulWidget {
  final String code;
  final String phone;

  const PasswordResetScreen({
    super.key,
    required this.code,
    required this.phone,
  });

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/arrow_topLeft.png"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png"),
                    const SizedBox(height: 20),
                    const Text(
                      "Create New Password",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    WhiteStrokeTextField(
                      hind: "Enter your new Password",
                      isPassword: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    WhiteStrokeTextField(
                      hind: "Confirm Password",
                      isPassword: true,
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Consumer<LoginProvider>(
                      builder: (context, provider, child) {
                        return whiteButton(
                          text: provider.isLoadingreset
                              ? "Please wait..."
                              : "Reset Password",
                          onpressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await provider.setNewPassword(
                                context: context,
                                phone: widget.phone,
                                code: widget.code,
                                newPassword: passwordController.text.trim(),
                              );

                              if (provider.response != null &&
                                  provider.response?.type == "success") {
                                
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const PasswordResetSuccesfull(),
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
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
