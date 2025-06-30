import 'package:etutor/features/quiz/styles/texView_styles.dart';
import 'package:flutter_tex/flutter_tex.dart';

class Quiz {
  final String type;
  final String statement;
  final List<QuizOption>? options;
  final String? correctOptionId;       // For SMCQ/KEAM
  final List<String>? correctOptionIds; // For MMCQ
  final int? correctAnswer;             // For numerical
  String? selectedOptionId;            // For SMCQ/KEAM
  List<String>? selectedOptionIds;     // For MMCQ
  String? enteredAnswer;               // For numerical

  Quiz({
    required this.type,
    required this.statement,
    this.options,
    this.correctOptionId,
    this.correctOptionIds,
    this.correctAnswer,
    this.selectedOptionId,
    this.selectedOptionIds,
    this.enteredAnswer,
  });
}

class QuizOption {
  final String id;
  final String option;
  final String optionLetter;
  TeXViewStyle? style;

  QuizOption(
    this.id,
    this.option,
    this.optionLetter, {
    this.style = TexViewStyles.quizItemStyleNormal,
  });
}
