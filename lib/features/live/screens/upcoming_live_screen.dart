import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/widgets/no_live_class.dart';
import 'package:flutter/material.dart';

class UpcomingLiveScreen extends StatelessWidget {
  const UpcomingLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.liveScreenBackground,
      body: noLiveClass(),
    );
  }
}

