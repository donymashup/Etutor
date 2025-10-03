import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class LiveCard extends StatelessWidget {
  final String img;
  final String title;
  final String date;
  final String time;
  const LiveCard({
    super.key,
    required this.date,
    required this.img,
    required this.time,
    required this.title,
  });

  List<String> formatDateTime(String input) {
    try {
      if (input.trim().isEmpty) throw FormatException();

      // Replace space with 'T' to make it ISO 8601 compatible if needed
      DateTime dt = DateTime.parse(input.replaceFirst(' ', 'T'));

      // Format the date as dd-mm-yyyy
      String formattedDate = "${dt.day.toString().padLeft(2, '0')}-"
          "${dt.month.toString().padLeft(2, '0')}-"
          "${dt.year}";

      // Format the time as hh:mm
      String formattedTime = "${dt.hour.toString().padLeft(2, '0')}:"
          "${dt.minute.toString().padLeft(2, '0')}";

      return [formattedDate, formattedTime];
    } catch (e) {
      return ["Invalid Date", "Invalid Time"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(color: AppColor.lightNightBlue),
        color: AppColor.greyCardBackground,
      ),
      width: MediaQuery.of(context).size.width,
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
                  image: CachedNetworkImageProvider(img),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.width * 0.2,
              width: MediaQuery.of(context).size.width * 0.36,
            ),
            SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          height: 1.2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12)),
                            Text(formatDateTime(date)[0],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12)),
                            Text(time,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12))
                          ],
                        )
                      ],
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
