import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class SubjectOverviewCard extends StatefulWidget {
  String title;
  String description;
  String subjectImage;

  SubjectOverviewCard(
      {required this.title,
      required this.description,
      required this.subjectImage,
      super.key});

  @override
  State<SubjectOverviewCard> createState() => _SubjectOverviewCardState();
}

class _SubjectOverviewCardState extends State<SubjectOverviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.greyAppBar),
          child: Text(widget.title),
    );
  }
}
