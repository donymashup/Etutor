
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';

class CourseOverviewScreen extends StatefulWidget {
  const CourseOverviewScreen({super.key});

  @override
  State<CourseOverviewScreen> createState() => _CourseOverviewState();
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

class _CourseOverviewState extends State<CourseOverviewScreen> {

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Class 06 Foundation 25-26",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 10),
                Text("Fundamental Concepts and Skills for Beginners",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                Text("30,000 rs",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 10),
                Text("Welcome to the Class 06 Foundation Course section of our app! Here, we offer a comprehensive learning experience designed to help students excel in their academic journey. Our course provides a wide range of resources to support students in four key subjects: Science, Social Science, Mathematics, and Mental Ability. Through a combination of engaging videos, detailed study materials, practice tests, and live classes, we strive to enhance students' understanding and knowledge in these subjects. Our video lessons are carefully crafted by expert educators, covering each topic extensively and providing clear explanations. Students can access these videos at any time, allowing them to learn at their own pace and revisit concepts as needed. To further reinforce learning, we offer a vast collection of study materials. ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,),textAlign: TextAlign.justify,),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: const Text(
              "Testimonials",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.blackColor,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 12),
                ...List.generate(
                    testimonials.length,
                    (index) => TestimonialCard(
                        username: testimonials[index].username,
                        description: testimonials[index].description,
                        userimage: testimonials[index].userimage)),
                SizedBox(width: 12),
              ],
            ),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}