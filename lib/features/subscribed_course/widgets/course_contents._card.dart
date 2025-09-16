import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/see_course_contents_screen.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentsCard extends StatefulWidget {
  final String courseid;
  ContentsCard({super.key, required this.courseid});

  @override
  State<ContentsCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<ContentsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () async {
          await context.read<SubcribedCourseProvider>().fetchBatchFolderContent(
                context: context,
                parentid: "0",
                courseid: widget.courseid,
              );

          final batchContent =
              context.read<SubcribedCourseProvider>().batchFolderContent;

          if (batchContent != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeeCourseContentsScreen(
                 // batchFolderContent: batchContent,
                  courseid: widget.courseid
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No folders found")),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyStroke),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                leadingIconCard(
                    FluentUiEmojiIcon(
                      fl: Fluents.flOpenFileFolder,
                      h: 30,
                      w: 30,
                    ),
                    AppColor.lightYellowBg),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Course Contents",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Tap to view all other resources related to classess",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leadingIconCard(Widget icon, Color bgColor) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: bgColor),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: icon,
        ));
  }
}
