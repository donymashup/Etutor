import 'package:custom_timer/custom_timer.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/quiz/model/data_model.dart';
import 'package:etutor/features/quiz/model/quiz_model.dart';
import 'package:etutor/features/quiz/screens/quiz_completion_screen.dart';
import 'package:etutor/features/quiz/styles/texView_styles.dart';
import 'package:etutor/features/quiz/widgets/options_builder.dart';
import 'package:etutor/features/quiz/widgets/quiz_drawer.dart';
import 'package:etutor/features/quiz/widgets/quiz_nav_button.dart';
import 'package:etutor/features/quiz/widgets/submission_row.dart';
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
  Key _texViewKey = UniqueKey();
  bool isShowingAnswers = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      drawer: quizDrawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
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
                    vertical: 30,
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                spacing: 5,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: AppColor.fileIconColour),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10),
                                      child: Text(
                                        "Section 1",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: AppColor.greyText),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10),
                                      child: Text(
                                        "Section 2",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: AppColor.greyText),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.whiteColor),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10),
                                      child: Text(
                                        "Section 3",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu_open_rounded,
                                color: AppColor.whiteColor,
                              ))
                        ],
                      ),
                      SizedBox(height: 10),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: CustomButton(
                                  onpressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                      child: const Text(
                                                        'Are you sure you want End the test?',
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    SubmissionRow("Total Questions", "5", Icons.question_mark_rounded),
                                                    SizedBox(height: 10),
                                                    SubmissionRow("Questions Answered", "3", Icons.check),
                                                    SizedBox(height: 10),
                                                    SubmissionRow("Questions Unanswered", "1", Icons.close),
                                                    SizedBox(height: 10),
                                                    SubmissionRow("Total Questions Unattended", "1", Icons.warning_amber_outlined),
                                                    SizedBox(height: 20),
                                                    CustomButton(
                                                        onpressed: () {
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              QuizCompletionScreen()));
                                                        },
                                                        text: "Submit Test",
                                                        buttoncolor: AppColor
                                                            .secondaryColor,
                                                        textColor:
                                                            AppColor.whiteColor)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  text: "Submit",
                                  buttoncolor: AppColor.fileIconColour,
                                  textColor: AppColor.whiteColor)),
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: AppColor.greenBarGraph,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Correct: ",
                                      style: TextStyle(
                                          color: AppColor.whiteColor)),
                                  Text(
                                    "+5",
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  Icon(Icons.check,
                                      color: AppColor.redBarGraph),
                                  SizedBox(width: 5),
                                  Text("Wrong: ",
                                      style: TextStyle(
                                          color: AppColor.whiteColor)),
                                  Text(
                                    "-1",
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _texViewKey =
                                    UniqueKey(); // 🔁 Triggers full TeXView reload
                              });
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
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
                  fontWeight: FontWeight.w600,
                  color: Colors.orange),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TeXView(
                    key: _texViewKey,
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
                                borderSide: BorderSide(
                                    color: AppColor.primaryColor, width: 2),
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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

  Color getQuestionContainerColor({
    required Quiz quiz,
    required int index,
    required int currentQuizIndex,
  }) {
    // Case 1: Currently selected question
    if (index == currentQuizIndex) {
      return Colors.green.shade100;
    }

    // Case 2: Answered (user interacted with it)
    final isAnswered = quiz.type == "smcq" || quiz.type == "keam"
        ? quiz.selectedOptionId != null
        : quiz.type == "mmcq"
            ? quiz.selectedOptionIds != null &&
                quiz.selectedOptionIds!.isNotEmpty
            : quiz.type == "numerical"
                ? quiz.enteredAnswer != null &&
                    quiz.enteredAnswer!.trim().isNotEmpty
                : false;

    // Case 3: Not selected but answered
    if (isAnswered) {
      return Colors.blue.shade100; // You can choose another color if you'd like
    }

    // Case 4: Default
    return Colors.orangeAccent.shade100;
  }

  Widget quizDrawer() {
    return Drawer(
      backgroundColor: AppColor.whiteColor,
      child: Column(
        children: [
          // Top Section
          Container(
            decoration: const BoxDecoration(
              color: AppColor.primaryColor,
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "Questions Overview",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Section 1",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),

          // Questions list with TeXView
          Expanded(
              child: SingleChildScrollView(
                  child: Wrap(
            spacing: 10,
            children: [
              ...List.generate(
                  DataModel.quizList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentQuizIndex = index;
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: getQuestionContainerColor(
                                  quiz: DataModel.quizList[index],
                                  index: index,
                                  currentQuizIndex: currentQuizIndex),
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text((index + 1).toString(),
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ))
            ],
          ))),

          // Bottom section with summary
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        height: 10, width: 10, color: Colors.blue.shade100),
                    SizedBox(width: 10),
                    Text("Answered")
                  ],
                ),
                Row(
                  children: [
                    Container(
                        height: 10,
                        width: 10,
                        color: Colors.orangeAccent.shade100),
                    SizedBox(width: 10),
                    Text("Not Answered")
                  ],
                ),
                Row(
                  children: [
                    Container(
                        height: 10, width: 10, color: Colors.green.shade100),
                    SizedBox(width: 10),
                    Text("Current Question")
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total Questions",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${DataModel.quizList.length}",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "0/${DataModel.quizList.length}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
