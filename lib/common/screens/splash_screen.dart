import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/provider/api_key_provider.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/auth/screen/onboarding_screen.dart';
import 'package:etutor/features/auth/screen/phone_number_auth.dart';
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
  String? hasLoggedInBefore;
  
  try {
    token = await secureStorage.read(key: 'token');
    hasLoggedInBefore = await secureStorage.read(key: 'hasLoggedInBefore');
    
  } catch (e) {
    debugPrint('Error reading from secure storage: $e');
    token = null;
    hasLoggedInBefore = null;
  }

  //No token exists
  if (token == null || token.isEmpty) {
    if (hasLoggedInBefore == 'true') {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
      );
      return;
    } else {
      // First time user
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
      return;
    }
  }

  // Token exists
  try {
    await context.read<UserDetailsProvider>().loadUserDetails(context);
    final data = context.read<UserDetailsProvider>().userDetails;
    
    if (!mounted) return;
    
    if (data.type == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  const PhoneNumberAuth()),
      );
    }
  } catch (e) {
    debugPrint('Error loading user details: $e');
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
    );
  }
}

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
