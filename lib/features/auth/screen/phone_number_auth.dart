import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/otp_screen.dart';
import 'package:etutor/features/auth/screen/password_screen.dart';
import 'package:etutor/features/auth/screen/registration.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PhoneNumberAuth extends StatefulWidget {
  const PhoneNumberAuth({super.key});

  @override
  State<PhoneNumberAuth> createState() => _PhoneNumberAuthState();
}

class _PhoneNumberAuthState extends State<PhoneNumberAuth> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String phoneNumber = '';
  String code = '';
  String countrysign = '';
  bool showPasswordField = false;

  void _onPhoneChanged(phone) {
    setState(() {
      phoneNumber = phone.number;
      countrysign = phone.countryCode;
      code = phone.countryCode.replaceAll(RegExp(r'\D'), '');
    });
  }

  Future<void> _onVerifyPressed(BuildContext context) async {
    final loginProvider = context.read<LoginProvider>();
    if (!showPasswordField) {
      if (_formKey.currentState?.validate() ?? false) {
        loginProvider.setPhoneNumber(phoneNumber, code, countrysign);
        await loginProvider.checkMobileExist(context, phoneNumber, code);
        if (loginProvider.isExist != null) {
          if (loginProvider.isExist!) {
            setState(() {
              showPasswordField = true;
            });
            showSnackbar(
                context, 'Welcome Back, Enter password to complete login');
          } else {
            showSnackbar(context, 'Enter the OTP to proceed');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OtpScreen()),
            );
          }
        } else {
          showSnackbar(context, 'Something went wrong, please try again');
          loginProvider.resetLoading();
        }
      } else {
        showSnackbar(context, 'Please enter a valid phone number');
      }
    } else {
      await _login(context);
    }
  }

  Future<void> _login(BuildContext context) async {
    final loginProvider = context.read<LoginProvider>();
    if (phoneNumberController.text.isEmpty) {
      showSnackbar(context, 'Phone number is required');
      return;
    }
    if (passwordController.text.length < 6) {
      showSnackbar(context, 'Password must be at least 6 characters');
      return;
    }
    await loginProvider.login(context, passwordController.text);
    if (loginProvider.isLogin.isNotEmpty) {
      showSnackbar(context, 'Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
      );
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
                    showPasswordField ? "Welcome Back!" : "Welcome Learner!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    showPasswordField
                        ? "Enter your password to continue learning"
                        : "Enter your mobile number to get started",
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
                        IntlPhoneField(
                          controller: phoneNumberController,
                          initialCountryCode: 'IN',
                          style: const TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          dropdownTextStyle:
                              const TextStyle(color: AppColor.whiteColor),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 18),
                            hintText: 'Enter your Mobile number',
                            hintStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                            filled: true,
                            fillColor: AppColor.primaryColor.withOpacity(0.15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: AppColor.whiteColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  color: AppColor.whiteColor, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: AppColor.whiteColor),
                            ),
                          ),
                          onChanged: _onPhoneChanged,
                          validator: (phone) {
                            if (phone == null || phone.number.isEmpty) {
                              return 'Please enter a phone number';
                            } else if (phone.number.length < 8) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                          readOnly: showPasswordField,
                        ),
                        if (showPasswordField) ...[
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Enter your Password',
                              hintStyle: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                              filled: true,
                              fillColor:
                                  AppColor.primaryColor.withOpacity(0.15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: AppColor.whiteColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: AppColor.whiteColor, width: 2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: AppColor.whiteColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registration()),
                        );
                      },
                      child: whiteButton(
                        text:
                            showPasswordField ? "Login" : "Verify Phone Number",
                        onpressed: () => showPasswordField
                            ? _login(context)
                            : _onVerifyPressed(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/arrow_bottomright.png",
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
