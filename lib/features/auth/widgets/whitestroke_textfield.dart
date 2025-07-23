import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class WhiteStrokeTextField extends StatefulWidget {
  final String hind;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const WhiteStrokeTextField({
    super.key,
    required this.hind,
    this.isPassword = false,
    required this.controller,
    required this.validator,
  });

  @override
  State<WhiteStrokeTextField> createState() => _WhiteStrokeTextFieldState();
}

class _WhiteStrokeTextFieldState extends State<WhiteStrokeTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.whiteColorTrasparent,
        hintText: widget.hind,
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColor.whiteColor, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        prefixIcon: widget.isPassword
            ? const Icon(
                Icons.lock_outline_rounded,
                size: 18,
                color: AppColor.whiteColor,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: AppColor.whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
