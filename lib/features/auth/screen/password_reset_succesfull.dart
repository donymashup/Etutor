import 'dart:async';

import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PasswordResetSuccesfull extends StatefulWidget {
  const PasswordResetSuccesfull({super.key});

  @override
  State<PasswordResetSuccesfull> createState() => _PasswordResetSuccesfullState();
}

class _PasswordResetSuccesfullState extends State<PasswordResetSuccesfull> {
   @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavBarScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/succesfull.json',
                  fit: BoxFit.cover,
                ),
                Text(
                  "Reset Successful",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "You may now access your account using the new password",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
