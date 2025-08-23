import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/widgets/live_card.dart';
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
    getCompletedLiveClasses();
  }

  @override
  Widget build(BuildContext context) {
    completedLiveClassProvider = context.watch<LiveClassProvider>();

    return Scaffold(
        backgroundColor: AppColor.liveScreenBackground,
        body: completedLiveClassProvider.isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: (completedLiveClassProvider.completedLiveClasses[0].months?[0].data ?? []).length,
            itemBuilder: (context, index) {
              final live = (completedLiveClassProvider.completedLiveClasses[0].months?[0].data ?? [])[index];
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
