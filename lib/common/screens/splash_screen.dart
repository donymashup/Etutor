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
    String? isLogin;
    try {
      token = await secureStorage.read(key: 'token');
      isLogin = await secureStorage.read(key: 'isLogin');
    } catch (e) {
      token = null;
      isLogin = null;
    }
    
    if ( token == null || token.isEmpty){
      if(isLogin != 'true') {
        await secureStorage.write(key: 'token', value: '');
      await secureStorage.write(key: 'isLogin', value: '');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
      return;
      }else{
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
      );
      }
    }else{
    try {
      await context.read<UserDetailsProvider>().loadUserDetails(context);
      final data =context.watch<UserDetailsProvider>().userDetails;
      if (!mounted) return;
        if(data.type == "success"){ 
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
        );
        }else{
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
      );
        }
    } catch (e) {
      await secureStorage.write(key: 'token', value: '');
      await secureStorage.write(key: 'isLogin', value: '');
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
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
