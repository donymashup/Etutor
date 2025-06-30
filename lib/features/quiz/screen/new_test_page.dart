import 'package:custom_timer/custom_timer.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/quiz/model/data_model.dart';
import 'package:etutor/features/quiz/model/quiz_model.dart';
import 'package:etutor/features/quiz/styles/texView_styles.dart';
import 'package:etutor/features/quiz/widgets/options_builder.dart';
import 'package:etutor/features/quiz/widgets/quiz_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TexViewQuizScreen extends StatefulWidget {
  const TexViewQuizScreen({super.key});

  @override
  State<TexViewQuizScreen> createState() => _TexViewQuizScreenState();
}

class _TexViewQuizScreenState extends State<TexViewQuizScreen>
    with SingleTickerProviderStateMixin {
  int currentQuizIndex = 0;
  String currentSelectedId = "";
  List<String> currentCheckedIds = [];
  bool isWrong = false;
  bool isShowingAnswers = false;

  // Add TextEditingController for numerical input
  final TextEditingController _numericalController = TextEditingController();
  late final CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: Duration(hours: 20),
      end: Duration(),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.milliseconds);

  @override
  void dispose() {
    // Don't forget to dispose the controller
    _numericalController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Quantum Mechanics Questions",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Study on Quantum Entanglement",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              CustomTimer(
                                  controller: _controller,
                                  builder: (state, time) {
                                    return Text(
                                        "${time.hours}:${time.minutes}:${time.seconds}",
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            color: AppColor.whiteColor));
                                  })
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Progress line
              Align(
                alignment: Alignment.bottomLeft,
                child: FractionallySizedBox(
                  widthFactor:
                      (currentQuizIndex + 1) / DataModel.quizList.length,
                  child: Container(height: 6, color: Colors.orange),
                ),
              ),
            ],
          ),

          // Question & Option Section
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
            child: Text(
              'Question ${currentQuizIndex + 1} of ${DataModel.quizList.length}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TeXView(
                    child: TeXViewColumn(
                      children: [
                        TeXViewDocument(
                          DataModel.quizList[currentQuizIndex].statement,
                          style: const TeXViewStyle(
                            padding: TeXViewPadding.all(20),
                            backgroundColor: Colors.white,
                            borderRadius: TeXViewBorderRadius.all(12),
                          ),
                        ),

                        // Answer Options for KEAM/SMCQ
                        if (DataModel.quizList[currentQuizIndex].type ==
                                "keam" ||
                            DataModel.quizList[currentQuizIndex].type == "smcq")
                          ...DataModel.quizList[currentQuizIndex].options!
                              .map((QuizOption option) {
                            bool isSelected = currentSelectedId == option.id;
                            String cardHTML = OptionsBuilder
                                    .createRadioButtonHTML(
                                        option.optionLetter, isSelected) +
                                option.option +
                                OptionsBuilder.closeRadioButtonHTML(isSelected);

                            return TeXViewInkWell(
                              rippleEffect: true,
                              id: option.id,
                              child: TeXViewDocument(cardHTML,
                                  style: const TeXViewStyle(
                                      padding: TeXViewPadding.all(0))),
                              style: option.style,
                              onTap: (id) {
                                // Prevent interaction while showing answers
                                if (isShowingAnswers) return;

                                setState(() {
                                  currentSelectedId = id;
                                  isWrong = false;
                                  DataModel.quizList[currentQuizIndex]
                                      .selectedOptionId = id;

                                  for (var element in DataModel
                                      .quizList[currentQuizIndex].options!) {
                                    element.style =
                                        TexViewStyles.quizItemStyleNormal;
                                  }
                                  option.style =
                                      TexViewStyles.quizItemStyleSelected;
                                });
                              },
                            );
                          })

                        // Answer Options for MMCQ
                        else if (DataModel.quizList[currentQuizIndex].type ==
                            "mmcq")
                          ...DataModel.quizList[currentQuizIndex].options!
                              .map((QuizOption option) {
                            bool isSelected =
                                currentCheckedIds.contains(option.id);
                            String cardHTML = OptionsBuilder
                                    .createRadioButtonHTML(
                                        option.optionLetter, isSelected) +
                                option.option +
                                OptionsBuilder.closeCheckboxHTML(isSelected);

                            return TeXViewInkWell(
                              rippleEffect: true,
                              id: option.id,
                              child: TeXViewDocument(cardHTML,
                                  style: const TeXViewStyle(
                                      padding: TeXViewPadding.all(0))),
                              style: option.style,
                              onTap: (id) {
                                // Prevent interaction while showing answers
                                if (isShowingAnswers) return;

                                setState(() {
                                  if (currentCheckedIds.contains(id)) {
                                    currentCheckedIds.remove(id);
                                  } else {
                                    currentCheckedIds.add(id);
                                  }

                                  isWrong = false;

                                  for (var element in DataModel
                                      .quizList[currentQuizIndex].options!) {
                                    element.style = currentCheckedIds
                                            .contains(element.id)
                                        ? TexViewStyles.quizItemStyleSelected
                                        : TexViewStyles.quizItemStyleNormal;
                                  }
                                });
                              },
                            );
                          }),
                      ],
                    ),
                    style: const TeXViewStyle(
                      margin: TeXViewMargin.only(
                          left: 26, right: 26, bottom: 10, top: 1),
                      padding: TeXViewPadding.all(0),
                      backgroundColor: Color(0xFFF5F5F5),
                    ),
                  ),

                  // Show TextField for numerical type questions (outside TeXView)
                  if (DataModel.quizList[currentQuizIndex].type == "numerical")
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 26),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your numerical answer:",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _numericalController,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                              signed: true,
                            ),
                            enabled: !isShowingAnswers,
                            decoration: InputDecoration(
                              hintText: "Enter your answer",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                            ),
                            style: TextStyle(fontSize: 16),
                            onChanged: (value) {
                              // You can add validation or other logic here
                              // The value is automatically stored in _numericalController.text
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Buttons Container
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Previous Button
                      QuizNavButton(
                        label: "Previous",
                        onPressed: (currentQuizIndex > 0 && !isShowingAnswers)
                            ? () {
                                setState(() {
                                  currentQuizIndex--;
                                  _resetQuestionState();
                                });
                              }
                            : null,
                      ),

                      SizedBox(width: 10),

                      // Next Button
                      QuizNavButton(
                        onPressed: (currentQuizIndex <
                                    DataModel.quizList.length - 1 &&
                                !isShowingAnswers)
                            ? () async {
                                final currentQuestion =
                                    DataModel.quizList[currentQuizIndex];

                                // Store numerical answer before moving to next question
                                if (currentQuestion.type == "numerical") {
                                  String numericalAnswer =
                                      _numericalController.text.trim();
                                  // You can store this answer in your data model or process it as needed
                                  print("Numerical answer: $numericalAnswer");

                                  // Optional: Store in your data model
                                  // currentQuestion.numericalAnswer = numericalAnswer;
                                }

                                // Only show answers for non-numerical questions
                                if (currentQuestion.type != "numerical") {
                                  setState(() {
                                    isShowingAnswers = true;
                                    _showCorrectAnswers(currentQuestion);
                                  });

                                  // Wait for 1 second to show answers
                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                }

                                // Move to next question
                                setState(() {
                                  isShowingAnswers = false;
                                  currentQuizIndex++;
                                  _resetQuestionState();
                                });
                              }
                            : null,
                        label: "Next",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetQuestionState() {
    final currentQuestion = DataModel.quizList[currentQuizIndex];

    if (currentQuestion.type == "mmcq") {
      // Handle multiple choice questions - initialize based on correctOptionIds
      currentCheckedIds = [];
      currentSelectedId = "";
    } else if (currentQuestion.type == "numerical") {
      // Handle numerical questions - clear the text field
      _numericalController.clear();
      currentSelectedId = "";
      currentCheckedIds = [];
    } else {
      // Handle single choice questions (keam/smcq)
      currentSelectedId = currentQuestion.selectedOptionId ?? "";
      currentCheckedIds = [];
    }

    isWrong = false;

    // Reset option styles
    if (currentQuestion.options != null) {
      for (var option in currentQuestion.options!) {
        if (currentQuestion.type == "mmcq") {
          option.style = currentCheckedIds.contains(option.id)
              ? TexViewStyles.quizItemStyleSelected
              : TexViewStyles.quizItemStyleNormal;
        } else {
          option.style = (currentSelectedId == option.id)
              ? TexViewStyles.quizItemStyleSelected
              : TexViewStyles.quizItemStyleNormal;
        }
      }
    }
  }

  void _showCorrectAnswers(Quiz currentQuestion) {
    if (currentQuestion.options != null) {
      for (var element in currentQuestion.options!) {
        if (element.id == currentQuestion.correctOptionId) {
          element.style = TexViewStyles.quizItemStyleCorrect;
        } else if (element.id == currentSelectedId ||
            currentCheckedIds.contains(element.id)) {
          element.style = TexViewStyles.quizItemStyleError;
        }
      }
    }
  }
}
