import 'dart:async';

import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    _checkToken();
  }
 Future<void> _checkToken() async {
  // await context.read<UserDetailsProvider>().loadUserDetails(context);
   final secureStorage = const FlutterSecureStorage();
  //  UserDetailsProvider userProvider = UserDetailsProvider();
  //  userProvider = Provider.of<UserDetailsProvider>(context, listen: true);
  //  if (userProvider.userDetails.type == 'danger'){
  //    await secureStorage.write(key: 'token', value: '');
  //  }

  final token = await secureStorage.read(key: 'token'); 
  await Future.delayed(const Duration(seconds: 3)); 

  if (!mounted) return;

  if (token != null && token.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
    );
  }
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.08,
            child: Image.asset(
              "assets/images/splash_bg.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/logo_without_bg.png",
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
        ],
      ),
    );
  }
}


