import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/screens/pdf_viewer.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseMaterials extends StatefulWidget {
  const SubscribedCourseMaterials({super.key});

  @override
  State<SubscribedCourseMaterials> createState() =>
      _SubscribedCourseMaterialsState();
}

class Materials {
  String title;
  String subtitle;
  String type;
  void Function(BuildContext) onPressed;

  Materials(
      {required this.title,
      required this.subtitle,
      required this.type,
      required this.onPressed});
}

class _SubscribedCourseMaterialsState extends State<SubscribedCourseMaterials> {
  List<Materials> materials = [
    Materials(
      title: "Chapter 1 Notes",
      subtitle: "Tap to view this pdf",
      type: "pdf",
      onPressed: (BuildContext context) => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PdfViewer())),
    ),
    Materials(
      title: "Chapter 2 Notes",
      subtitle: "Tap to view this pdf",
      type: "pdf",
      onPressed: (BuildContext context) => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PdfViewer())),
    ),
    Materials(
        title: "Figure 2.9",
        subtitle: "Tap to view this image",
        type: "pdf",
        onPressed: (_) {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Materials",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Text(
              //   "Materials",
              //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              //   textAlign: TextAlign.center,
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: materials.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: CourseCard(
                      title: materials[index].title,
                      subtitle: materials[index].subtitle,
                      type: materials[index].type,
                      onPressed: () => materials[index].onPressed(context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
