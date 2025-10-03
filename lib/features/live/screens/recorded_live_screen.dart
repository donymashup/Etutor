import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/screens/live_vedio_player.dart';
import 'package:etutor/features/live/widgets/live_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordedLiveScreen extends StatefulWidget {
  final String month;
  const RecordedLiveScreen({super.key, required this.month});

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
    getCompletedLiveClasses();
  }


  String getTimeDuration(String startTime, String endTime) {
  try {
    DateTime start = DateTime.parse(startTime.replaceFirst(' ', 'T'));
    DateTime end = DateTime.parse(endTime.replaceFirst(' ', 'T'));
    Duration duration = end.difference(start);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);

    return "${hours}h ${minutes}m";
  } catch (e) {
    return "Invalid time";
  }
}


  @override
  Widget build(BuildContext context) {
    completedLiveClassProvider = context.watch<LiveClassProvider>();

    return Scaffold(
      backgroundColor: AppColor.liveScreenBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.month,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: (completedLiveClassProvider.completedLiveMonth.data ?? []).length,
        itemBuilder: (context, index) {
          final live = (completedLiveClassProvider.completedLiveMonth.data ?? [])[index];
          final duration = getTimeDuration(live.start ?? "",live.end ?? "");
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveVedioPlayer(
                    playlist: completedLiveClassProvider.completedLiveMonth.data!,
                    contentid: live.id ?? '',
                  ),
                ),
              );
            },
            child: LiveCard(
              img: live.avatar ?? "",
              time: duration,
              date: live.start ?? "",
              title: live.title ?? "",
            ),
          );
        },
      ),
    );
  }
}
