import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/screen/test_home.dart';
import 'package:etutor/features/my_course/screens/my_course.dart';
import 'package:flutter/material.dart';

class CourseCurriculumCard extends StatefulWidget {
  String title;
  String classname;
  String subject;
  final List<String> items;
 final Function(String) onPressed;

  CourseCurriculumCard({
    required this.title,
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
    return Card(
      color: AppColor.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
              side: BorderSide.none, 
            ),
            collapsedShape: RoundedRectangleBorder(
              side: BorderSide.none,
            ),
          title: Text(widget.title,style: TextStyle(fontWeight: FontWeight.w600),),
          subtitle: Row(
            children: [
              Text(widget.classname ),
              SizedBox(height: 10,
                child: VerticalDivider()),
              Text(widget.subject),
            ],
          ),
          children: widget.items.map((item) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  tileColor: AppColor.greyCardBackground,
                  // tileColor: AppColor.whiteColor,
                  title: Text(item, style: const TextStyle(fontSize: 16)),
                  onTap: () {
                    widget.onPressed(item);
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
    );
  }
}
