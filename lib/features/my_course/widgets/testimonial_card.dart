import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TestimonialCard extends StatefulWidget {
  final String username;
  final String userimage;
  final String description;

  const TestimonialCard(
      {required this.username,
      required this.description,
      required this.userimage,
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
                    backgroundImage: AssetImage(widget.userimage),
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
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColor.fileIconColour,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.fileIconColour,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.fileIconColour,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.fileIconColour,
                              size: 18,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.fileIconColour,
                              size: 18,
                            ),
                          ],
                        ),
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
