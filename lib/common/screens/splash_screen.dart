import 'dart:async';

import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PhoneNumberAuth())));
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/Splash_screen.png"),
            fit: BoxFit.cover),
      ),
      child: Center(
        child: Image.asset(
          "assets/images/etutor_logo.png",
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .4,
        ),
      ),
    );
  }
}
