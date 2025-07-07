import 'package:etutor/common/screens/splash_screen.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/payment/controller/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';

void main() async {
  await TeXRenderingServer.start();
  runApp(
    ChangeNotifierProvider(
      create:  (_) => PaymentProvider(),
      child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.whiteColor),
        useMaterial3: true,
      ),
      home: SplashScreen(),   
    );
  }
}

