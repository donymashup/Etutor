// import 'package:etutor/features/quiz/model/data_model.dart';
// import 'package:flutter/material.dart';
// import 'package:etutor/common/constants/app_constants.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html_math/flutter_html_math.dart';
// import 'package:flutter_math_fork/flutter_math.dart';
// import 'package:flutter_tex/flutter_tex.dart';

// class QuestionsDrawer extends StatefulWidget {
//   bool isDrawerOpen;
//   final Function(bool)? onDrawerStateChanged;
//   final Function(int)?
//       onQuestionSelected; // Add callback for question selection

//   QuestionsDrawer(
//     this.isDrawerOpen, {
//     super.key,
//     this.onDrawerStateChanged,
//     this.onQuestionSelected,
//   });

//   @override
//   State<QuestionsDrawer> createState() => _QuestionsDrawerState();
// }

// class _QuestionsDrawerState extends State<QuestionsDrawer> {
//   List<String> questions = [
//     r"""<h3>What is the correct form of quadratic formula?</h3>""",
//     r"""
//         <div style="font-size: 18px;">
//           <b>Which of the following represents the formula for kinetic energy?</b><br><br>
//           <img src="https://www.fire2fusion.com/assets/images/kinetic-energy/Picture1.png?_cchid=74c1a074cc814493e4574fba722d8b0a" width="200px" />
//         </div>
//       """,
//     r"""<h3>Choose the correct mathematical form of Bohr's Radius.</h3>""",
//     r"""<h3>Select the correct Chemical Balanced Equation.</h3>""",
//     r"""\(x = {-b \pm \sqrt{b^2+4ac} \over 2a}\)""",
//     r"""<h3>Solve for x: \(x = {-b \pm \sqrt{b^2+4ac} \over 2a}\)""",
//     r"""<h3>Calculate the derivative of $$f(x) = x^3 + 2x^2 - 5x$$</h3>""",
//     r"""<div><b>Einstein's Mass-Energy Equation:</b><br>$$E = mc^2$$</div>""",
//     r"""<h3>Find the integral: $$\int x^2 dx$$</h3>""",
//     r"""<div><b>Schrödinger Equation:</b><br>$$i\hbar\frac{\partial}{\partial t}\Psi = \hat{H}\Psi$$</div>"""
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Notify parent that drawer is being opened
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       widget.onDrawerStateChanged?.call(true);
//     });
//   }

//   bool isTex(String str) {
//     final trimmed = str.trim();
//     return trimmed.startsWith(r"""\(""") && trimmed.endsWith(r"""\)""");
//   }

//   TeXViewDocument buildContent(String item) {
//     return TeXViewDocument(item);
//   }

//   @override
//   void dispose() {
//     // Notify parent that drawer is being closed
//     widget.onDrawerStateChanged?.call(false);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppColor.whiteColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(32),
//           bottomLeft: Radius.circular(40),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Top Section
//           Container(
//             decoration: const BoxDecoration(
//               color: AppColor.primaryColor,
//             ),
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 30),
//             child: Column(
//               children: [
//                 SizedBox(height: 30),
//                 Text(
//                   "Questions Overview",
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: AppColor.whiteColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "Section 1",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: AppColor.whiteColor,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 15),

//           // Questions list with TeXView
//           Expanded(
//               child: SingleChildScrollView(
//                   child: Column(
//             children: [
//               ...List.generate(
//                   questions.length,
//                   (index) => Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 6),
//                         child: Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: buildContent(questions[index]),
//                         ),
//                       ))
//             ],
//           ))),

//           // Bottom section with summary
//           Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               border: Border(
//                 top: BorderSide(color: Colors.grey[300]!, width: 1),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Total Questions",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "${questions.length}",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: AppColor.primaryColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Completed",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "0/${questions.length}",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.green[600],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
