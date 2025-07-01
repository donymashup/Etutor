import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  String title;
  String subtitle;
  Widget icon;
  Color iconBgColor;
  void Function() onPressed;

  CourseCard({
      super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.iconBgColor,
      required this.onPressed,
      });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    //course card structure
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyStroke),
            color: Colors.white),
        width: MediaQuery.of(context).size.width ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //icon and background of icon
              Container(
                decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),
                color: widget.iconBgColor),
                // height: MediaQuery.of(context).size.width * 0.1,
                // width: MediaQuery.of(context).size.width * 0.1,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                child: widget.icon,
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  //title and subtitle of the course
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      Text(widget.subtitle,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
              //icon for moving to next page
              IconButton(onPressed: widget.onPressed, icon: Icon(Icons.arrow_forward_ios))
            ],
          ),
        ),
      ),
    );
  }
}
