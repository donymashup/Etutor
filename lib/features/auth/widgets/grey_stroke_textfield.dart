// custom textformfield with greystroke
import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class GreystokeTextfield extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const GreystokeTextfield({
    super.key,
    required this.hintText,
    required this.iconData,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.greyText),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.greyStroke, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.greyStroke, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        prefixIcon: Icon(iconData, color: AppColor.greyIcon, size: 18),
        suffixIcon: isPassword
            ? Icon(Icons.visibility_off_outlined,
                color: AppColor.greyIcon, size: 18)
            : null,
      ),
    );
  }
}
