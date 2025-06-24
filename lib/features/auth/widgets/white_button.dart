import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class whiteButton extends StatelessWidget {
  String text;
  void Function() onpressed;
  whiteButton({
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
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text("Verify Phone Number",
            style: TextStyle(
              color: AppColor.primaryColor,
            )),
      ),
    );
  }
}
