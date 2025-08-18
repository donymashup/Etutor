// import 'package:etutor/common/constants/app_constants.dart';
// import 'package:etutor/features/my_course/screens/my_course.dart';
// import 'package:flutter/material.dart';

// class CourseCurriculumCard extends StatefulWidget {
//   String title;
//   String classname;
//   String subject;
//   final List<String> items;
//   final Function() onPressed;

//   CourseCurriculumCard(
//       {required this.title,
//       required this.classname,
//       required this.subject,
//       required this.items,
//       required this.onPressed,
//       super.key});

//   @override
//   State<CourseCurriculumCard> createState() => _CourseCurriculumCardState();
// }

// class _CourseCurriculumCardState extends State<CourseCurriculumCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Card(
//         color: AppColor.whiteColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 3,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           child: ExpansionTile(
//             tilePadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//             shape: RoundedRectangleBorder(
//               side: BorderSide.none,
//             ),
//             collapsedShape: RoundedRectangleBorder(
//               side: BorderSide.none,
//             ),
//             title: Text(
//               widget.title,
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//             subtitle: Row(
//               children: [
//                 Text(widget.classname),
//                 SizedBox(height: 10, child: VerticalDivider()),
//                 Expanded(child: Text(widget.subject, maxLines: 1, overflow: TextOverflow.ellipsis,)),
//               ],
//             ),
//             children: widget.items.map((item) {
//               return Padding(
//                 padding: widget.items.indexOf(item) == (widget.items.length - 1)
//                     ? EdgeInsets.only(
//                         left: 16.0, right: 16.0, top: 5, bottom: 16)
//                     : EdgeInsets.only(
//                         left: 16.0, right: 16.0, top: 5, bottom: 5),
//                 child: ListTile(
//                   tileColor: AppColor.greyCardBackground,
//                   // tileColor: AppColor.whiteColor,
//                   title: Text(item, style: const TextStyle(fontSize: 16)),
//                   onTap: () {
//                     widget.onPressed();
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => MyCoursePage()));
//                   },
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/payment/screen/checkout_screen.dart';
import 'package:etutor/features/subscribed_course/screens/video_player_screen.dart';
import 'package:flutter/material.dart';

class CourseCurriculumCard extends StatefulWidget {
  final String title;
  final String classname;
  final String subject;
  final List<String> items;
  final Function() onPressed;

  const CourseCurriculumCard({
    required this.title,
    required this.classname,
    required this.subject,
    required this.items,
    required this.onPressed,
    super.key,
  });

  @override
  State<CourseCurriculumCard> createState() => _CourseCurriculumCardState();
}

class _CourseCurriculumCardState extends State<CourseCurriculumCard> {
  @override
  Widget build(BuildContext context) {
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
            children: List.generate(widget.items.length, (index) {
              final item = widget.items[index];
              final isFree = index == 0; // First item is free

              return Padding(
                padding: index == (widget.items.length - 1)
                    ? const EdgeInsets.only(
                        left: 16, right: 16, top: 5, bottom: 16)
                    : const EdgeInsets.only(
                        left: 16, right: 16, top: 5, bottom: 5),
                child: ListTile(
                  tileColor: AppColor.greyCardBackground,
                  title: Text(item, style: const TextStyle(fontSize: 16)),

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
                          widget.onPressed();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(VideoTitle: "",Videolink: "",VideoSource: "",Videohls: "",),
                            ),
                          );
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
                                                  CheckoutScreen()));
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
