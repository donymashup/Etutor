import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CourseSubjectCard extends StatefulWidget {

  String subjectName;
  String subjectImage;
  void Function() onPressed;

  CourseSubjectCard({
  required this.subjectName,
  required this.subjectImage, 
  required this.onPressed, 
  super.key});

  @override
  State<CourseSubjectCard> createState() => _CourseSubjectCardState();
}

class _CourseSubjectCardState extends State<CourseSubjectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.greyStroke),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.subjectName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: widget.onPressed, icon: Icon(Icons.arrow_drop_down))
          ],
        ),
      ),
    );
  }
}
