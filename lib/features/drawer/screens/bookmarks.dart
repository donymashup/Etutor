import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/widgets/material_card.dart';
import 'package:etutor/features/subscribed_course/widgets/video_card.dart';
import 'package:flutter/material.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({super.key});

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const Text(
          "Bookmarks",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.whiteColor,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Materials Section
            Text(
              "Materials",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(height: 8),

            const MaterialCard(
              materialName: "Chapter 1 Notes",
              materialDescription: "Tap to view this pdf",
              packageChapterId: "1",
              link: "https://example.com/sample1.pdf",
            ),
            const MaterialCard(
              materialName: "Chapter 2 Notes",
              materialDescription: "Tap to view this pdf",
              packageChapterId: "2",
              link: "https://example.com/sample2.pdf",
            ),

            const SizedBox(height: 16),

            /// Videos Section
            Text(
              "Videos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(height: 8),

            const VideoCard(
              title: "Foundation Class 25-26 for students from class 6 - 7 f...",
              img: "https://img.youtube.com/vi/0LHxvxdRnYc/maxresdefault.jpg",
              duration: "1hr 24min",
              progress: 0.6,
            ),
            const VideoCard(
              title: "Foundation Class 26-27 for students from class 7 - 8 f...",
              img: "https://img.youtube.com/vi/0LHxvxdRnYc/maxresdefault.jpg",
              duration: "1hr 15min",
              progress: 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
