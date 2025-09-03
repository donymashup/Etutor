import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/chapter_card_overview_provider.dart';
import 'package:etutor/features/subscribed_course/screens/video_player_screen.dart';
import 'package:etutor/features/subscribed_course/widgets/listview_shimmer_loader.dart';
import 'package:etutor/features/subscribed_course/widgets/video_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class SubscribedCourseVedio extends StatefulWidget {
  final String packageChapterId;
  const SubscribedCourseVedio({super.key, required this.packageChapterId});

  @override
  State<SubscribedCourseVedio> createState() => _SubscribedCourseVideoState();
}

class _SubscribedCourseVideoState extends State<SubscribedCourseVedio> {
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await context.read<ChapterCardOverviewProvider>().fetchChapterVideos(
        context: context, packageChapterId: widget.packageChapterId);
  }

// function to format duration into hr/min/sec style
  String formatDuration(String? durationInMinutes) {
    if (durationInMinutes == null || durationInMinutes.isEmpty) {
      return "0 min";
    }

    final totalMinutes = int.tryParse(durationInMinutes) ?? 0;
    final totalSeconds = totalMinutes * 60; // convert minutes → seconds

    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    String result = "";

    if (hours > 0) result += "$hours hr ";
    if (minutes > 0) result += "$minutes mins ";
    if (seconds > 0) result += "$seconds sec";

    return result.trim().isEmpty ? "0 min" : result.trim();
  }

  double convertToRatio(double value1, double value2) {
    if (value2 == 0) return 0;
    return value1 / value2;
  }

  @override
  Widget build(BuildContext context) {
    final chapterCardOverviewProvider =
        context.watch<ChapterCardOverviewProvider>();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: const Text(
          "Chapter Videos",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: chapterCardOverviewProvider.isLoadingVideos
          ? ListviewShimmerLoader()
          : (chapterCardOverviewProvider.chapterVideos?.data == null ||
                  chapterCardOverviewProvider.chapterVideos!.data!.isEmpty)
              ? const Center(child: Text("No videos available"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: chapterCardOverviewProvider
                            .chapterVideos!.data!.length,
                        itemBuilder: (context, index) {
                          final videolist = chapterCardOverviewProvider
                              .chapterVideos!.data![index];

                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(
                                 playlist: chapterCardOverviewProvider.chapterVideos!.data!,
                                 contentid: videolist.id ?? '',
                                ),
                              ),
                            ),
                            child: VideoCard(
                              title: videolist.name ?? "Untitled",
                              img: videolist.thumbnail ?? "",
                              duration: formatDuration(videolist.duration),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
    );
  }
}