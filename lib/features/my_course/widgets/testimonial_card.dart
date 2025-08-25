import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TestimonialCard extends StatefulWidget {
  final String username;
  final String userimage;
  final String description;
  final String rating;

  const TestimonialCard(
      {required this.username,
      required this.description,
      required this.userimage,
      required this.rating,
      super.key});

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyStroke),
            color: AppColor.whiteColor),
        width: MediaQuery.of(context).size.width * .9,
        // height: MediaQuery.of(context).size.width *.34,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColor.greyAppBar,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.userimage, // Your network image URL
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 50,
                        height: 50,
                        color: AppColor.greyAppBar,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[400],
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10.0),
                    child:
                        //username and icon of the course
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        ratingtoStar(double.parse(widget.rating)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //review description
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
