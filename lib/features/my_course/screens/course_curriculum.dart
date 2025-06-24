import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/widgets/course_curriculum_card.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';

class CourseCurriculum extends StatefulWidget {
  @override
  State<CourseCurriculum> createState() => _CourseCurriculumState();
}

class Testimonials {
  String username;
  // IconData rating;
  String userimage;
  String description;

  Testimonials({
    required this.username,
    // required this.rating,
    required this.description,
    required this.userimage,
  });
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

  List<Testimonials> testimonials = [
    Testimonials(
        username: "Arjun Ashokan",
        description:
            "eTutor has completely changed the way I learn—it's interactive, easy to use, and keeps me engaged every step of the way!",
        userimage: "assets/images/arjun.webp"),
    Testimonials(
        username: "Aiswarya Lakshmi",
        description:
            "Thanks to eTutor, I can now study anytime, anywhere with expert guidance and structured lessons tailored just for me.",
        userimage: "assets/images/aish.jpg"),
    Testimonials(
        username: "Basil Joseph",
        description:
            "The personalized learning experience on eTutor helped me improve my scores and stay motivated throughout the course",
        userimage: "assets/images/basil.jpg"),
    Testimonials(
        username: "Mamitha Baiju",
        description:
            "I love how eTutor breaks down tough subjects into simple concepts. It's like having a personal tutor at home.",
        userimage: "assets/images/mamitha.webp"),
    Testimonials(
        username: "Gopika Ramesh",
        description:
            "With eTutor, I finally feel confident in subjects I used to struggle with. It's the best study companion!",
        userimage: "assets/images/gopika.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
             ...List.generate(curriculum.length, (index) => CourseCurriculumCard(
              title: curriculum[index].title, 
              classname: curriculum[index].classname, subject: curriculum[index].title, items: curriculum[index].items, onPressed: (){}))
              ,SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(
                        testimonials.length,
                        (index) => TestimonialCard(
                            username: testimonials[index].username,
                            description: testimonials[index].description,
                            userimage: testimonials[index].userimage))
                  ],
                ),
              )
              ,SizedBox(height: 70,)
            ],
          ),
        ),
      ),
    );
  }
}
