import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/model/course_details_model.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/my_course/screens/free_content_vedioplayer.dart';
import 'package:etutor/features/payment/screen/checkout_screen.dart';
import 'package:etutor/features/subscribed_course/screens/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCurriculumCard extends StatefulWidget {
  final String title;
  final String classname;
  final String subject;
  // final List<String> names;
  // final List<String> status;
  // final List<String> source;
  // final List<String> link;
  // final List<String> contentType;
  final List<Contents> contents;
  
  const CourseCurriculumCard({
    required this.title,
    required this.classname,
    required this.subject,
    // required this.names,
    // required this.status,
    // required this.link,
    // required this.source,
    // required this.contentType,
    required this.contents,
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
            children: List.generate(widget.contents.length, (index) {
              // final name = widget.names[index];
              // final isFree = widget.status[index] != "paid";
              // final source = widget.source[index];
              // final type = widget.contentType[index];
              // final link = widget.link[index];
              final content_details = widget.contents[index];
              final isFree = content_details.status != "paid";
              return Padding(
                padding: index == (widget.contents.length - 1)
                    ? const EdgeInsets.only(
                        left: 16, right: 16, top: 5, bottom: 16)
                    : const EdgeInsets.only(
                        left: 16, right: 16, top: 5, bottom: 5),
                child: ListTile(
                  tileColor: AppColor.greyCardBackground,
                  title: Text(content_details.contentName ?? '', style: const TextStyle(fontSize: 16)),

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
                      : const Icon(Icons.lock_outline,
                          color: AppColor.blackColor),
                  onTap: isFree
                      ? () {
                          if(content_details.contentType == 'video')
                         { 
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FreeContentVedioplayer(
                                videolink:content_details.link ?? '', 
                                videoTitle: content_details.contentName ?? '', 
                                videoSource: content_details.source ?? '', 
                                videohls: '',),
                            ),
                          );
                          }else if(content_details.contentType =='pdf'){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfViewer(
                                link:content_details.link ?? '' , 
                                title: content_details.contentName ?? '',
                                contentId:content_details.contentId ?? '',)
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
                                                    price:  courseDetailsProvider.courseDetails.price ?? '', 
                                                    courseId: courseDetailsProvider.courseDetails.id ?? '',)));
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
