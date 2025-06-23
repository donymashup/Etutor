import 'package:etutor/features/my_course/widgets/course_curriculum_card.dart';
import 'package:flutter/material.dart';

class CourseCurriculum extends StatefulWidget {
  const CourseCurriculum({super.key});

  @override
  State<CourseCurriculum> createState() => _CourseCurriculumState();
}

class _CourseCurriculumState extends State<CourseCurriculum> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      CourseCurriculumCard(classname: "Class7",subject: "Science",title: "FOOD:WHERE DOES IT COME FROM?",items: ["Food Variety", "Food Materials and Sources", "Plant Parts and Animal Products as Food"],onPressed: (value) {}),
      CourseCurriculumCard(classname: "Class 8",subject: "Science",title: "COMPONENTS OF FOOD",items: ["Carbohydrates, Proteins, Fats, Vitamins, and Minerals", "Balanced diet", "Deficiency diseases"],onPressed: (value) {}),
      CourseCurriculumCard(classname: "Class 9",subject: "Social Science",title: "History – Our Pasts",items: ["From Hunting–Gathering to Growing Food", "In the Earliest Cities", "Kingdoms, Kings and an Early Republic"],onPressed: (value) {}),
         
      ],
    );
  }
}
