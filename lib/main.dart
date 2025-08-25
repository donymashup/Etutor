import 'package:etutor/common/provider/network_provider.dart';
import 'package:etutor/common/screens/network_dialog.dart';
import 'package:etutor/common/screens/splash_screen.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/chapter_analysis/provider/chapter_analysis_provider.dart';
import 'package:etutor/features/home/provider/homepage_provider.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/my_course/provider/my_course_provider.dart';
import 'package:etutor/features/payment/controller/payment_provider.dart';
import 'package:etutor/features/subscribed_course/provider/chapter_card_overview_provider.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/test_series/provider/test_series_provider.dart';
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
        ChangeNotifierProvider(create: (_) => MyCourseProvider()),
        ChangeNotifierProvider(create: (_) => SubcribedCourseProvider()),
        ChangeNotifierProvider(create: (_) => TestSeriesProvider()),
        ChangeNotifierProvider(create: (_) => ChapterCardOverviewProvider()),
        ChangeNotifierProvider(create: (_) => LiveClassProvider()),
        ChangeNotifierProvider(create: (_) => ChapterAnalysisProvider()),
        ChangeNotifierProvider(create: (_)=> CourseDetailsProvider())
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