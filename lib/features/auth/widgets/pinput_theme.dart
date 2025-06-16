import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: AppColor.whiteColor,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color: AppColor.whiteColorTrasparent,
      border: Border.all(color: AppColor.whiteColor),
      borderRadius: BorderRadius.circular(5),
    ),
  );