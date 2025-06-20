import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        image: DecorationImage(
        image: AssetImage("assets/images/nodata.png"))
      ),
    );
  }
}