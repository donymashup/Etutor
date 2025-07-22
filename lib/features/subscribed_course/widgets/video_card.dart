//card for gk video
import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String title;
  final String img;
  final String duration;
  final double progress;

  const VideoCard({
    super.key,
    required this.duration,
    required this.img,
    required this.title,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(color: AppColor.lightNightBlue),
        color: AppColor.greyCardBackground,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.25,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.secondaryColor),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width * 0.39,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.27,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Duration",
                          style:
                              TextStyle(color: AppColor.greyText, fontSize: 13),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Text(
                          duration,
                          style: TextStyle(fontSize: 13),
                        )),
                        Icon(
                          Icons.play_circle_fill_outlined,
                          color: AppColor.primaryColor,
                          size: 24,
                        )
                      ],
                    ),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColor.greyAppBar,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.secondaryColor),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
