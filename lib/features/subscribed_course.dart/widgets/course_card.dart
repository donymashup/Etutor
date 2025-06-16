import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  String title;
  String subtitle;
  IconData icon;
  Color Iconbgcolor;
  void Function() onPressed;
  

  CourseCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.Iconbgcolor,
      required this.onPressed
      
      });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.greyStroke),
          color: Colors.white),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(color: widget.Iconbgcolor, child: Icon(widget.icon)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title),
                  Text(widget.subtitle),
                ],
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    );
  }
}
