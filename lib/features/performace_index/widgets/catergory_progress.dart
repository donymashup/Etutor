import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CatergoryProgress extends StatelessWidget {
  const CatergoryProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.greyBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
        child: Column(
          children: [
            // Left Column
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("12hr 30min", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      Text("Total Learning Time", style: TextStyle(fontSize: 10, color: AppColor.greyTextDark)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: VerticalDivider(
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("12", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      Text("Courses Completed", style: TextStyle(fontSize: 10, color: AppColor.greyTextDark)),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(width: 10),
                  Expanded(child: Divider())
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("20", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      Text("Ongoing Courses", style: TextStyle(fontSize: 10, color: AppColor.greyTextDark)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: VerticalDivider(
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("18", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      Text("Quizzes Completed", style: TextStyle(fontSize: 10, color: AppColor.greyTextDark)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
