import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/otp_screen.dart';
import 'package:etutor/features/auth/screen/password_screen.dart';
import 'package:etutor/features/auth/screen/registration.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PhoneNumberauth extends StatefulWidget {
  const PhoneNumberauth({super.key});

  @override
  State<PhoneNumberauth> createState() => _PhoneNumberAuthState();
}

class _PhoneNumberAuthState extends State<PhoneNumberauth> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  String phoneNumber = '';
  String code = '';
  String countrysign = '';

  void _onPhoneChanged(phone) {
    setState(() {
      phoneNumber = phone.number;
      countrysign = phone.countryCode;
      code = phone.countryCode.replaceAll(RegExp(r'\D'), '');
    });
  }

  Future<void> _onVerifyPressed(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final loginProvider = context.read<LoginProvider>();
      loginProvider.setPhoneNumber(phoneNumber, code, countrysign);
      await loginProvider.checkMobileExist(context, phoneNumber, code);
      if (loginProvider.isExist != null) {
        if (loginProvider.isExist!) {
          showSnackbar(
              context, 'Welcome Back, Enter password to complete login');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PasswordScreen()),
          );
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
                        height: 32,
                        width: 32,
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
                    "Welcome Learner!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Enter your mobile number to get started",
                    style: TextStyle(
                      color: AppColor.whiteColor.withOpacity(0.85),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    child: IntlPhoneField(
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
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColor.whiteColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColor.whiteColor, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                        text: "Verify Phone Number",
                        onpressed: () => _onVerifyPressed(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/arrow_bottomright.png",
                        height: 32,
                        width: 32,
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
