import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  String title;
  String subtitle;
  IconData icon;
  Color Iconbgcolor;
  Color Iconcolor;
  void Function() onPressed;

  CourseCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.Iconbgcolor,
      required this.onPressed,
      required this.Iconcolor
      });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    //course card structure
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.greyStroke),
          color: Colors.white),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width ,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //icon and background of icon
            Container(
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: widget.Iconbgcolor, ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
            child: Icon(widget.icon,color: widget.Iconcolor,size: 40,)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
              //title and subtitle of the course
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title),
                  Text(widget.subtitle),
                ],
              ),
            ),
            //icon for moving to next page
            IconButton(onPressed: widget.onPressed, icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    );
  }
}
