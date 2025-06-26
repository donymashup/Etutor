import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccesfull extends StatelessWidget {
  const PaymentSuccesfull({super.key});

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
                  "Payment Successful",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
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