import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/provider/api_key_provider.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/auth/screen/onboarding_screen.dart';
import 'package:etutor/features/auth/screen/sample.dart';
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
    _navigateAfterDelay();
  }

Future<void> _navigateAfterDelay() async {
  final secureStorage = const FlutterSecureStorage();
  await Future.delayed(const Duration(seconds: 2));
  await context.read<ApiKeyProvider>().fetchApiKey();
  
  String? token;
  String? hasLoggedInBefore; // This tracks if user has EVER logged in
  
  try {
    token = await secureStorage.read(key: 'token');
    hasLoggedInBefore = await secureStorage.read(key: 'hasLoggedInBefore');
    
    print('Token: ${token?.isNotEmpty == true ? "EXISTS" : "NULL/EMPTY"}');
    print('Has logged in before: $hasLoggedInBefore');
    
  } catch (e) {
    print('Error reading from secure storage: $e');
    token = null;
    hasLoggedInBefore = null;
  }

  // Case 1: No token exists
  if (token == null || token.isEmpty) {
    // If user has EVER logged in before (even if they logged out), go to phone auth
    if (hasLoggedInBefore == 'true') {
      print('No token but user has logged in before - going to phone auth');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
      );
      return;
    } else {
      // First time user - show onboarding
      print('First time user - going to onboarding');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
      return;
    }
  }

  // Case 2: Token exists - validate it
  print('Token exists - validating user details');
  try {
    await context.read<UserDetailsProvider>().loadUserDetails(context);
    final data = context.read<UserDetailsProvider>().userDetails;
    
    if (!mounted) return;
    
    if (data.type == "success") {
      print('User details valid - going to bottom nav');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
      );
    } else {
      print('User details invalid - going to phone auth');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
      );
    }
  } catch (e) {
    print('Error loading user details: $e');
    // Token exists but validation failed - user has logged in before, so go to phone auth
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
    );
  }
}

  // Future<void> _navigateAfterDelay() async {
  //   final secureStorage = const FlutterSecureStorage();
  //   await Future.delayed(const Duration(seconds: 2));
  //   await context.read<ApiKeyProvider>().fetchApiKey();
  //   String? token;
  //   String? isLogin;
  //   try {
  //     token = await secureStorage.read(key: 'token');
  //     isLogin = await secureStorage.read(key: 'isLogin');
  //   } catch (e) {
  //     token = null;
  //     isLogin = null;
  //   }
    
  //   if ( token == null || token.isEmpty){
  //     if(isLogin != 'true') {
  //       await secureStorage.write(key: 'token', value: '');
  //     await secureStorage.write(key: 'isLogin', value: '');
  //     if (!mounted) return;
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const OnboardingScreen()),
  //     );
  //     return;
  //     }else{
  //         Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
  //     );
  //     }
  //   }else{
  //   try {
  //     await context.read<UserDetailsProvider>().loadUserDetails(context);
  //     final data =context.watch<UserDetailsProvider>().userDetails;
  //     if (!mounted) return;
  //       if(data.type == "success"){ 
  //       Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
  //       );
  //       }else{
  //         Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
  //     );
  //       }
  //   } catch (e) {
  //     await secureStorage.write(key: 'token', value: '');
  //     await secureStorage.write(key: 'isLogin', value: '');
  //     if (!mounted) return;
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const OnboardingScreen()),
  //     );
  //   }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: Image.asset(
                "assets/images/splash_bg.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_without_bg.png",
                  height: media.size.height * 0.32,
                  width: media.size.width * 0.32,
                ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
