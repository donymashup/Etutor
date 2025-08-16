import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubjectOverviewCard extends StatefulWidget {
  final String title;
  final String description;
  final String subjectImage;

  const SubjectOverviewCard(
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
            SizedBox(
              height: MediaQuery.of(context).size.width * .2,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: widget.subjectImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(color: Colors.grey.shade300),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image, size: 40),
              ),
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
