import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/widgets/course_curriculum_card.dart';
import 'package:flutter/material.dart';

class CourseCurriculum extends StatefulWidget {
  @override
  State<CourseCurriculum> createState() => _CourseCurriculumState();
}

class Curriculum {
  String classname;
  String title;
  List<String> items;

  Curriculum(
      {required this.title, required this.classname, required this.items});
}

class _CourseCurriculumState extends State<CourseCurriculum> {
  List<Curriculum> curriculum = [
    Curriculum(
      title: "FOOD:WHERE DOES IT COME FROM?",
      classname: "Class 7",
      items: [
        "Carbohydrates, Proteins, Fats, Vitamins, and Minerals",
        "Balanced diet",
        "Deficiency diseases"
      ],
    ),
    Curriculum(
      title: "COMPONENTS OF FOOD",
      classname: "Class 8",
      items: [
        "Carbohydrates, Proteins, Fats, Vitamins, and Minerals",
        "Balanced diet",
        "Deficiency diseases"
      ],
    ),
    Curriculum(
      title: "History – Our Pasts",
      classname: "Class 7",
      items: [
        "From Hunting–Gathering to Growing Food",
        "In the Earliest Cities",
        "Kingdoms, Kings and an Early Republic"
      ],
    ),
    Curriculum(
      title: "FOOD:WHERE DOES IT COME FROM?",
      classname: "Class 9",
      items: [
        "From Hunting–Gathering to Growing Food",
        "In the Earliest Cities",
        "Kingdoms, Kings and an Early Republic"
      ],
    ),
    Curriculum(
      title: "FOOD:WHERE DOES IT COME FROM?",
      classname: "Class7",
      items: [
        "Carbohydrates, Proteins, Fats, Vitamins, and Minerals",
        "Balanced diet",
        "Deficiency diseases"
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                  curriculum.length,
                  (index) => CourseCurriculumCard(
                      title: curriculum[index].title,
                      classname: curriculum[index].classname,
                      subject: curriculum[index].title,
                      items: curriculum[index].items,
                      onPressed: () {})),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
