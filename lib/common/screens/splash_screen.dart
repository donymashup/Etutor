import 'dart:async';

import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
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
  final secureStorage = const FlutterSecureStorage();
  final token = await secureStorage.read(key: 'token');
  
  try {
    // check if token is null or empty
    if (token == null || token.isEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
      );
      return;
    }

    await context.read<UserDetailsProvider>().loadUserDetails(context);
    final isLogin = await secureStorage.read(key: 'isLogin');
    
    if (isLogin == 'false') {
      // Token is invalid or expired
      await secureStorage.write(key: 'token', value: '');
      await secureStorage.write(key: 'isLogin', value: '');
      
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
      );
    } else {
      // Token is valid
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
      );
    }
    
  } catch (e) {
    debugPrint('Error checking token: $e');
    await secureStorage.write(key: 'token', value: '');
    await secureStorage.write(key: 'isLogin', value: '');
    
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    
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


