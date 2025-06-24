
import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(                       
      alignment: Alignment.center,
      child: Container(
        width: 36,
        height: 36,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: AppColor.whiteColor,borderRadius: BorderRadius.circular(22),border:Border.all(color: AppColor.greyStroke)),
        child: IconButton(
          iconSize: 18,
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              color:AppColor.greyIconDark ),
        ),
      ),
    );
  }
}