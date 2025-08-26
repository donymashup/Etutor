import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/my_course/screens/free_content_vedioplayer.dart';
import 'package:etutor/features/payment/screen/checkout_screen.dart';
import 'package:etutor/features/subscribed_course/screens/pdf_viewer.dart';
import 'package:etutor/features/subscribed_course/screens/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCurriculumCard extends StatefulWidget {
  final String title;
  final String classname;
  final String subject;
  final List<String> names;
  final List<String> status;
  final List<String> source;
  final List<String> link;
  final List<String> contentType;

  const CourseCurriculumCard({
    required this.title,
    required this.classname,
    required this.subject,
    required this.names,
    required this.status,
    required this.link,
    required this.source,
    required this.contentType,
    super.key,
  });

  @override
  State<CourseCurriculumCard> createState() => _CourseCurriculumCardState();
}

class _CourseCurriculumCardState extends State<CourseCurriculumCard> {
   CourseDetailsProvider courseDetailsProvider = CourseDetailsProvider();

  @override
  Widget build(BuildContext context) {
     courseDetailsProvider = context.watch<CourseDetailsProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: AppColor.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ExpansionTile(
            // Course title and class info
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: const RoundedRectangleBorder(side: BorderSide.none),
            collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
            title: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              children: [
                Text(widget.classname),
                const SizedBox(height: 10, child: VerticalDivider()),
                Expanded(
                  child: Text(
                    widget.subject,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Curriculum items list
            children: List.generate(widget.names.length, (index) {
              final name = widget.names[index];
              final isFree = widget.status[index] != "paid"; // First item is free
              final source = widget.source[index];
              final type = widget.contentType[index];
              final link = widget.link[index];

              return Padding(
                padding: index == (widget.names.length - 1)
                    ? const EdgeInsets.only(
                        left: 16, right: 16, top: 5, bottom: 16)
                    : const EdgeInsets.only(
                        left: 16, right: 16, top: 5, bottom: 5),
                child: ListTile(
                  tileColor: AppColor.greyCardBackground,
                  title: Text(name, style: const TextStyle(fontSize: 16)),

                  // Trailing icon or "Free" label
                  trailing: isFree
                      ? Text(
                          "Free",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.greenStroke,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      // Icon(Icons.lock_open, color: AppColor.greenchaptertest)
                      : const Icon(Icons.lock_outline,
                          color: AppColor.blackColor),
                  // Tap only if item is free
                  onTap: isFree
                      ? () {
                          if(type == 'video')
                         { 
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FreeContentVedioplayer(videolink:link, videoTitle: name, videoSource: source, videohls: '',),
                            ),
                          );
                          }else if(type =='pdf'){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewer(link:link , title: name)
                            ),
                          );
                          }
                        }
                      : () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Subscription needed'),
                                content: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                        'Once enrolled, you’ll get full access to the course materials. Do you want to proceed?')),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          (context),
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckoutScreen(
                                                    image: courseDetailsProvider.courseDetails.image ?? '', 
                                                    name:  courseDetailsProvider.courseDetails.name ?? '', 
                                                    price:  courseDetailsProvider.courseDetails.price ?? '',)));
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
