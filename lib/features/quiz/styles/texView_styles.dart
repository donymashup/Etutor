import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TexViewStyles {
  static const TeXViewStyle quizItemStyleCorrect = TeXViewStyle(
    margin: TeXViewMargin.all(8),
    padding: TeXViewPadding.all(15),
    borderRadius: TeXViewBorderRadius.all(12),
    backgroundColor: Color(0xFFF0FFF4),
    border: TeXViewBorder.all(
      TeXViewBorderDecoration(
          borderColor: Colors.green,
          borderStyle: TeXViewBorderStyle.solid,
          borderWidth: 2),
    ),
  );

  static const TeXViewStyle quizItemStyleSelected = TeXViewStyle(
    margin: TeXViewMargin.all(8),
    padding: TeXViewPadding.all(15),
    borderRadius: TeXViewBorderRadius.all(12),
    backgroundColor: Colors.white,
    border: TeXViewBorder.all(
      TeXViewBorderDecoration(
          borderColor: Colors.indigo,
          borderStyle: TeXViewBorderStyle.solid,
          borderWidth: 2),
    ),
  );

  static const TeXViewStyle quizItemStyleError = TeXViewStyle(
    margin: TeXViewMargin.all(8),
    padding: TeXViewPadding.all(15),
    borderRadius: TeXViewBorderRadius.all(12),
    backgroundColor: Color(0xFFFFF5F5),
    border: TeXViewBorder.all(
      TeXViewBorderDecoration(
          borderColor: Colors.red,
          borderStyle: TeXViewBorderStyle.solid,
          borderWidth: 2),
    ),
  );

  static const TeXViewStyle quizItemStyleNormal = TeXViewStyle(
    margin: TeXViewMargin.only(left: 20, top: 8, right: 8, bottom: 8),
    padding: TeXViewPadding.all(15),
    borderRadius: TeXViewBorderRadius.all(12),
    backgroundColor: Colors.white,
    border: TeXViewBorder.all(
      TeXViewBorderDecoration(
          borderColor: Color(0xFFE0E0E0),
          borderStyle: TeXViewBorderStyle.solid,
          borderWidth: 1),
    ),
  );
}
