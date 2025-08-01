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

class PhoneNumberAuth extends StatefulWidget {
  const PhoneNumberAuth({super.key});

  @override
  State<PhoneNumberAuth> createState() => _PhoneNumberAuthState();
}

class _PhoneNumberAuthState extends State<PhoneNumberAuth> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  String phoneNumber = '';
  String code = '';
  String countrysign = '';

 // String? errorText;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LoginProvider>().isLoding;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: isLoading
          ?  Center(child: Lottie.asset('assets/lottie/lottieloading1.json'))
          : SingleChildScrollView(
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
                    child: Column(
                      children: [
                         Image.asset("assets/images/logo_without_bg.png"),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 15),

                        /// Phone number input with validation
                        Form(
                          key: _formKey,
                          child: IntlPhoneField(
                            controller: phoneNumberController,
                            initialCountryCode: 'IN',
                            style: const TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            dropdownTextStyle:
                                const TextStyle(color: AppColor.whiteColor),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              hintText: 'Enter your Mobile number',
                              hintStyle: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColor.whiteColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColor.whiteColor, width: 1.5),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: AppColor.whiteColor),
                              ),
                            ),
                            onChanged: (phone) {
                              phoneNumber = phone.number;
                              countrysign =  phone.countryCode;
                              code = phone.countryCode
                                  .replaceAll(RegExp(r'\D'), '');
                            },
                            validator: (phone) {
                              if (phone == null || phone.number.isEmpty) {
                                return 'Please enter a phone number';
                              } else if (phone.number.length < 10) {
                                return 'Enter a valid 10-digit number';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        GestureDetector(
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registration()),
                            );
                          },
                          child: whiteButton(
                            text: "Verify Phone Number",
                            onpressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  phoneNumber != "" &&
                                  code != "") {
                                final loginProvider =
                                    context.read<LoginProvider>();
                                loginProvider.setPhoneNumber(phoneNumber, code, countrysign);

                                await loginProvider.checkMobileExist(
                                    context, phoneNumber, code);
                                if (loginProvider.isExist != null) {
                                  if (loginProvider.isExist! == true) {
                                    showSnackbar(context, 'Welcome Back, Enter password to complete login');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PasswordScreen()),
                                    );
                                  } else {
                                    showSnackbar(context, 'Enter the OTP to proceed');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OtpScreen()),
                                    );
                                  }
                                } else {
                                 showSnackbar(context, 'Something went wrong could not proceed try again');
                                }
                              } else {
                               showSnackbar(context, 'Please enter a valid phone number');
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 45),
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
