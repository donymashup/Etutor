import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';

class CourseReview extends StatefulWidget {
  const CourseReview({super.key});

  @override
  State<CourseReview> createState() => _CourseReviewState();
}

class Testimonials {
  String username;
  String userimage;
  String description;

  Testimonials({
    required this.username,
    required this.description,
    required this.userimage,
  });
}

class _CourseReviewState extends State<CourseReview> {
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
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: testimonials.length,
                    itemBuilder: (context, index) => TestimonialCard(
                        username: testimonials[index].username,
                        description: testimonials[index].description,
                        userimage: testimonials[index].userimage)),
              ),
              SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
