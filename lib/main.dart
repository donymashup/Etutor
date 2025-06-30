import 'package:etutor/common/screens/splash_screen.dart';
import 'package:etutor/features/auth/screen/forgot_password.dart';
import 'package:etutor/features/auth/screen/otp_screen.dart';
import 'package:etutor/features/auth/screen/password_reset_otp.dart';
import 'package:etutor/features/auth/screen/password_reset_screen.dart';
import 'package:etutor/features/auth/screen/password_reset_succesfull.dart';
import 'package:etutor/features/auth/screen/password_screen.dart';
import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:etutor/features/auth/screen/registration.dart';
import 'package:etutor/features/auth/screen/test_home.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/screen/password_reset_succesfull.dart';
import 'package:etutor/features/live/screens/live_screen.dart';
import 'package:etutor/features/my_course/screens/course_details_screen.dart';
import 'package:etutor/features/my_course/screens/gk_post_screen.dart';
import 'package:etutor/features/my_course/screens/gk_vedios.dart';
import 'package:etutor/features/notification/screens/notification_page.dart';
import 'package:etutor/features/payment/screen/checkout_screen.dart';
import 'package:etutor/features/payment/screen/payment_method.dart';
import 'package:etutor/features/payment/screen/voucher_screen.dart';

import 'package:etutor/features/performace_index/screens/performance_index_screen.dart';
import 'package:etutor/features/profile.dart';
import 'package:etutor/features/quiz/screens/quiz_completion_screen.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_all_subjects.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_assignment_screen.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_content.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_materials.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_overview.dart';
import 'package:etutor/features/live/screens/ongoing_live_screen.dart';
import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:etutor/features/home/screen/home_screen.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_overview.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_subject.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_vedio.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_courses_tests.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.whiteColor),
        useMaterial3: true,
      ),
      // home: SplashScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: PasswordResetSuccesfull(),
      // home: TestHome(),
      // home: SubscribedCourseOverview(),
      // home: SubscribedCourseContent(),
      // home: SubscribedCourseAssignmentScreen(),
      // home: SubscribedCourseSubject(),
      // home: PerformanceIndexScreen(),
      // home: SubscribedCoursesTests(),
      // home: Registration(),
      // home: NotificationPage(),
      // home: ProfilePage()
      // home: CheckoutScreen(),
      // home: BottomNavBarScreen(),
      // //home: PaymentMethod(),
     // home:VoucherScreen(),
      // home: OngoingLiveScreen(),
      // home: CourseDetailsScreen(),
      //  home: GkPostScreen(),
          home: SplashScreen(),
      // home: PerformanceIndexScreen(),
      // home: NotificationPage(),
      // home: ProfilePage(),
    //  home: BottomNavBarScreen(),
      // home: OngoingLiveScreen(),
      // home: CourseDetailsScreen(),
     // home: HomePage(),
     // home: GkVedios(),
     // home: QuizCompletionScreen(),
    );
  }
}