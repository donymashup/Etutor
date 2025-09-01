import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/forgot_password.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:etutor/features/auth/widgets/whitestroke_textfield.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    final provider = context.read<LoginProvider>();
    if (_formKey.currentState?.validate() ?? false) {
      await provider.login(context, passwordController.text);
      if (provider.isLogin.isNotEmpty) {
        showSnackbar(context, 'Login successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LoginProvider>().isLoding;
    final media = MediaQuery.of(context);

    if (isLoading) {
      return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Center(
          child: Lottie.asset('assets/lottie/lottieloading1.json', height: 120),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/arrow_topLeft.png",
                        // height: 32,
                        // width: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    "assets/images/logo_without_bg.png",
                    height: media.size.height * 0.13,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter your password to continue learning",
                    style: TextStyle(
                      color: AppColor.whiteColor.withOpacity(0.85),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        WhiteStrokeTextField(
                          hind: "Enter your Password",
                          isPassword: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: whiteButton(
                            text: "Login",
                            onpressed: () => _login(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/arrow_bottomright.png",
                        // height: 32,
                        // width: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
