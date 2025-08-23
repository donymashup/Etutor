import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/widgets/live_card.dart';
import 'package:etutor/features/live/widgets/no_live_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OngoingLiveScreen extends StatefulWidget {
  const OngoingLiveScreen({super.key});

  @override
  State<OngoingLiveScreen> createState() => _OngoingLiveScreenState();
}

class _OngoingLiveScreenState extends State<OngoingLiveScreen> {
  LiveClassProvider ongoingLiveClassProvider = LiveClassProvider();

  @override
  void initState() {
    super.initState();
    getOngoingLiveClasses();
  }

  Future<void> getOngoingLiveClasses() async {
    final liveClassProvider = context.read<LiveClassProvider>();
    await liveClassProvider.fetchLiveClasses(context);
  }

  @override
  Widget build(BuildContext context) {
    ongoingLiveClassProvider = context.watch<LiveClassProvider>();

    return Scaffold(
        backgroundColor: AppColor.liveScreenBackground,
        body: ongoingLiveClassProvider.isLoading
        ? Center(child: CircularProgressIndicator())
        : ongoingLiveClassProvider.ongoingLiveClasses.isEmpty
        ? noLiveClass()
        : ListView.builder(
            itemCount: ongoingLiveClassProvider.ongoingLiveClasses.length,
            itemBuilder: (context, index) {
              final live = ongoingLiveClassProvider.ongoingLiveClasses[index];
              return Column(
                children: [
                  LiveCard(
                    img: live.avatar ?? "",
                    time: live.start ?? "",
                    date: live.start ?? "",
                    title: live.title ?? "",
                  ),
                ],
              );
            }));
  }
}
