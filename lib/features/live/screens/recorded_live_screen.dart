import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/screens/live_vedio_player.dart';
import 'package:etutor/features/live/widgets/live_card.dart';
import 'package:etutor/features/subscribed_course/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordedLiveScreen extends StatefulWidget {
  const RecordedLiveScreen({super.key});

  @override
  State<RecordedLiveScreen> createState() => _RecordedLiveScreenState();
}

class _RecordedLiveScreenState extends State<RecordedLiveScreen> {
  LiveClassProvider completedLiveClassProvider = LiveClassProvider();

  Future<void> getCompletedLiveClasses() async {
    final liveClassProvider = context.read<LiveClassProvider>();
    await liveClassProvider.fetchLiveClasses(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    completedLiveClassProvider = context.watch<LiveClassProvider>();

    return Scaffold(
        backgroundColor: AppColor.liveScreenBackground,
        body: ListView.builder(
                itemCount:
                    (completedLiveClassProvider.completedLiveMonth.data ?? [])
                        .length,
                itemBuilder: (context, index) {
                  final live =
                      (completedLiveClassProvider.completedLiveMonth.data ??
                          [])[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LiveVedioPlayer(
                                 playlist: completedLiveClassProvider.completedLiveMonth.data!,
                                 contentid: live.id ?? '',
                                 initialIndex: index,
                                ),
                              ));
                    },

                    child: LiveCard(
                      img: live.avatar ?? "",
                      time: live.start ?? "",
                      date: live.start ?? "",
                      title: live.title ?? "",
                    ),
                  );
                }));
  }
}
