import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class PhoneNumberAuth extends StatelessWidget {
  const PhoneNumberAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/images/arrow_topLeft.png"),
            ],
          ),
          Image.asset("assets/images/logo.png"),
          Text("Welcome Learner" , style: TextStyle(),)
        ],
      ),
    );
  }
}