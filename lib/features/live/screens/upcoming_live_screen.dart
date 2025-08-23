import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/widgets/live_card.dart';
import 'package:etutor/features/live/widgets/no_live_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingLiveScreen extends StatefulWidget {
  const UpcomingLiveScreen({super.key});

  @override
  State<UpcomingLiveScreen> createState() => _UpcomingLiveScreenState();
}

class _UpcomingLiveScreenState extends State<UpcomingLiveScreen> {
  LiveClassProvider upcomingLiveClassProvider = LiveClassProvider();

  Future<void> getUpcomingLiveClasses() async {
    final liveClassProvider = context.read<LiveClassProvider>();
    await liveClassProvider.fetchLiveClasses(context);
  }

  @override
  void initState() {
    super.initState();
    getUpcomingLiveClasses();
  }

  @override
  Widget build(BuildContext context) {
    upcomingLiveClassProvider = context.watch<LiveClassProvider>();

    return Scaffold(
      backgroundColor: AppColor.liveScreenBackground,
      body: upcomingLiveClassProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : upcomingLiveClassProvider.upcomingLiveClasses.isEmpty
              ? noLiveClass()
              : ListView.builder(
                  itemCount:
                      upcomingLiveClassProvider.upcomingLiveClasses.length,
                  itemBuilder: (context, index) {
                    final live =
                        upcomingLiveClassProvider.upcomingLiveClasses[index];
                    return LiveCard(
                        date: live.start ?? "",
                        img: live.avatar ?? "",
                        time: live.start ?? "",
                        title: live.title ?? "");
                  }),
    );
  }
}
