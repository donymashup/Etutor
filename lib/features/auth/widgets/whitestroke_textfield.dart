import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class WhiteStrokeTextField extends StatelessWidget {
  String hind;
  WhiteStrokeTextField({
    super.key,
    required this.hind,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.whiteColorTrasparent,
        hintText: hind,
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColor.whiteColor,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.white, 
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
