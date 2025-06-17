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
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Container(
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(10),
              image: DecorationImage(
                      image: AssetImage(widget.subjectImage),
                      fit: BoxFit.cover),
              color: AppColor.greyIcon
            ),
            height: MediaQuery.of(context).size.height ,
            width: MediaQuery.of(context).size.width * 0.4,
                     ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.subjectName,
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          IconButton(
              onPressed: widget.onPressed, icon: Icon(Icons.arrow_drop_down))
        ],
      ),
    );
  }
}
