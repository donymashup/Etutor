import 'package:etutor/common/constants/app_constants.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bxs.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class CourseCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String type;
  final void Function() onPressed;

  const CourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.onPressed,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  Widget cardIconContainer(String type) {
    switch (type) {
      case "class":
        return leadingIconCard(FluentUiEmojiIcon(
          fl: Fluents.flBlueBook,
          h: 30,
          w: 30,
        ), AppColor.lighBlueBackground);
      case "folder":
        return leadingIconCard(
            FluentUiEmojiIcon(
              fl: Fluents.flOpenFileFolder,
              h: 30,
              w: 30,
            ),
            AppColor.lightYellowBg);
      case "pdf":
        return leadingIconCard(
            Iconify(
              Mdi.pdf_box,
              size: 30,
              color: AppColor.redBarGraph,
            ),
            AppColor.lightRedCardBackground);
      case "test":
        return leadingIconCard(
            Iconify(
              Mdi.timer,
              size: 30,
              color: AppColor.testIconColour,
            ),
            AppColor.lightVioletCardBackground);
      case "video":
        return leadingIconCard(
            Iconify(
              Bxs.video,
              size: 30,
              color: AppColor.videoIconColor,
            ),
            AppColor.lighBlueBackground);
      case "image":
        return leadingIconCard(
            Icon(
              Icons.image,
              color: AppColor.greenchaptertest,
              size: 30,
            ),
            AppColor.lightGreenCardBackground);
      default:
        return leadingIconCard(Icon(Icons.error), AppColor.greyIcon);
    }
  }

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
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              //icon and background of icon
              // Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: widget.iconBgColor),
              //     // height: MediaQuery.of(context).size.width * 0.1,
              //     // width: MediaQuery.of(context).size.width * 0.1,
              //     child: Padding(
              //       padding: EdgeInsets.all(
              //           MediaQuery.of(context).size.width * 0.03),
              //       child: widget.icon,
              //     )),
              cardIconContainer(widget.type ?? ""),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                      //title and subtitle of the course
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(widget.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
              //icon for moving to next page
              IconButton(
                  onPressed: widget.onPressed,
                  icon: Icon(Icons.arrow_forward_ios))
            ],
          ),
        ),
      ),
    );
  }

  Widget leadingIconCard(Widget icon, Color bgColor) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: bgColor),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: icon,
        ));
  }
}
