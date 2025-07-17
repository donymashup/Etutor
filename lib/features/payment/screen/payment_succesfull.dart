import 'dart:async';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccesfull extends StatefulWidget {
  const PaymentSuccesfull({super.key});

  @override
  State<PaymentSuccesfull> createState() => _PaymentSuccesfullState();
}

class _PaymentSuccesfullState extends State<PaymentSuccesfull> {
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