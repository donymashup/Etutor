import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/screens/video_player_screen.dart';
import 'package:etutor/features/subscribed_course/widgets/video_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseVedio extends StatelessWidget {
  SubscribedCourseVedio({super.key});

  final List<Map<String, dynamic>> _videos = [
    {
      'title': "Foundation Class 25-26 forstudents from class 6 - 7 foundation",
      'img': "assets/images/course1.png",
      'duration': "1hr 30mins",
      'progress': 0.6,
    },
    {
      'title': "Foundation Class 25-26 forstudents from class 6 - 7 foundation",
      'img': "assets/images/course2.png",
      'duration': "1hr 30mins",
      'progress': 0.9,
    },
    {
      'title': "Foundation Class 25-26 forstudents from class 6 - 7 foundation",
      'img': "assets/images/course3.png",
      'duration': "1hr 00mins",
      'progress': 0.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Video",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                final video = _videos[index];
                return GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen())),
                  child: VideoCard(
                    title: video['title']!,
                    img: video['img']!,
                    duration: video['duration']!,
                    progress: video['progress']!,
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
