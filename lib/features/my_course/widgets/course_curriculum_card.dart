import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/screen/test_home.dart';
import 'package:etutor/features/my_course/screens/my_course.dart';
import 'package:flutter/material.dart';

class CourseCurriculumCard extends StatefulWidget {
  String title;
  String classname;
  String subject;
  final List<String> items;
  final Function() onPressed;

  CourseCurriculumCard(
      {required this.title,
      required this.classname,
      required this.subject,
      required this.items,
      required this.onPressed,
      super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ExpansionTile(
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            collapsedShape: RoundedRectangleBorder(
              side: BorderSide.none,
            ),
            title: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Row(
              children: [
                Text(widget.classname),
                SizedBox(height: 10, child: VerticalDivider()),
                Expanded(child: Text(widget.subject, maxLines: 1, overflow: TextOverflow.ellipsis,)),
              ],
            ),
            children: widget.items.map((item) {
              return Padding(
                padding: widget.items.indexOf(item) == (widget.items.length - 1)
                    ? EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 5, bottom: 16)
                    : EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 5, bottom: 5),
                child: ListTile(
                  tileColor: AppColor.greyCardBackground,
                  // tileColor: AppColor.whiteColor,
                  title: Text(item, style: const TextStyle(fontSize: 16)),
                  onTap: () {
                    widget.onPressed();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCoursePage()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
