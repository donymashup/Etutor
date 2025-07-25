import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/registration.dart';
import 'package:etutor/features/auth/widgets/pinput_theme.dart';
import 'package:etutor/features/auth/widgets/white_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final loginProvider = context.read<LoginProvider>();
     final phoneNumber = loginProvider.phone;
     final code = loginProvider.countrysign;
     int? otpPin;

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
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Enter the OTP send to your mobile number \n$code $phoneNumber",
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
                    keyboardType: TextInputType.number,
                    defaultPinTheme: defaultPinTheme,
                    validator: (value) {
                      if (value == null || value.length != 6) {
                        return 'Invalid OTP';
                      }
                      return null;
                    },
                    onCompleted: (pin) {
                        otpPin = int.tryParse(pin);
                    },
                    showCursor: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  whiteButton(
                    text: "Login",
                    onpressed: () {
                      final otpFinal = loginProvider.otp;
                      if (otpFinal == otpPin){
                           showSnackbar(context, "Verification Successful");
                           Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                              Registration() ));
                      }else{
                        showSnackbar(context, "Verification failed. Try again");
                      }      
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                           showSnackbar(context, "OTP Resend");
                           await loginProvider.checkMobileExist(
                                    context, phoneNumber, code);        
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                              text:"Didn’t receive an OTP? " ,
                              style: TextStyle(fontSize: 12,
                                    color: AppColor.whiteColor,
                                    fontFamily:'Poppins',
                                    )
                            ),
                            TextSpan(
                              text:"Send Again" ,
                              style: TextStyle(fontSize: 12,
                              color: AppColor.secondaryColor,
                              fontFamily:'Poppins',)
                            )]  
                          )
                        ),
                      )
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

