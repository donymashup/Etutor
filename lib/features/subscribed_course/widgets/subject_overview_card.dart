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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width * .5 - 35,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 2, strokeAlign: BorderSide.strokeAlignOutside,color: AppColor.greyAppBar)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.subjectImage),
                      fit: BoxFit.cover),
                  color: AppColor.greyAppBar),
              height: MediaQuery.of(context).size.width *.2,
              // width: MediaQuery.of(context).size.width *.5 - 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(widget.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
