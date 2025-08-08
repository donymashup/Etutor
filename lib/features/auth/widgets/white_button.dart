import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class whiteButton extends StatelessWidget {
 final  String text;
 final  void Function() onpressed;
  const whiteButton({
    required this.onpressed,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(text,
            style: TextStyle(
              color: AppColor.primaryColor,
            )),
      ),
    );
  }
}
