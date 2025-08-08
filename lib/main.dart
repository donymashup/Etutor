import 'package:etutor/common/provider/network_provider.dart';
import 'package:etutor/common/screens/network_dialog.dart';
import 'package:etutor/common/screens/splash_screen.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/home/provider/homepage_provider.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/payment/controller/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';

void main() async {
  await TeXRenderingServer.start();
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomepageProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),

      ],
      child: MyApp(),
      ),
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
       builder: (context, child) {
        return Stack(
          children: [
            child!,
            Consumer<NetworkProvider>(
              builder: (context, provider, _) {
                if (!provider.hasConnection) {
                  return const NoInternetDialog();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
      home: SplashScreen(),   
    );
  }
}