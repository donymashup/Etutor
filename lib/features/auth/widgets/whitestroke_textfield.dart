import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class WhiteStrokeTextField extends StatelessWidget {
  final String hind;
  final bool isPassword;
  const WhiteStrokeTextField({
    super.key,
    required this.hind,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      obscureText: isPassword ? true :false,
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
        prefixIcon: isPassword ? 
        Icon(
          Icons.lock_outline_rounded,
          size: 18,
          color: AppColor.whiteColor,)
          : null,
        suffixIcon: isPassword?
        Icon(Icons.visibility_off_outlined,
          size: 18,
          color: AppColor.whiteColor,)
        : null,  
      ),
    );
  }
}
