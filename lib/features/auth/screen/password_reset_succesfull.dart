import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PasswordResetSuccesfull extends StatelessWidget {
  const PasswordResetSuccesfull({super.key});
  

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
