import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/my_course/widgets/mycoursecard.dart';
import 'package:flutter/material.dart';

class SeeMoreCourses extends StatefulWidget {
  const SeeMoreCourses({super.key});

  @override
  State<SeeMoreCourses> createState() => _SeeMoreCoursesState();
}

class _SeeMoreCoursesState extends State<SeeMoreCourses> {
  
  final List<Map<String, dynamic>> courses = const [
    {
      'title': 'MENTAL ABILITY',
      'image': 'assets/images/course1.png',
      'isFree': true,
      'rating': 4.5
    },
    {
      'title': 'NMMS',
      'image': 'assets/images/course2.png',
      'isFree': false,
      'rating': 4.5
    },
    {
      'title': 'USS',
      'image': 'assets/images/course3.png',
      'isFree': false,
      'rating': 4.5
    },
    {
      'title': 'MENTAL ABILITY',
      'image': 'assets/images/course1.png',
      'isFree': true,
      'rating': 4.5
    },
    {
      'title': 'NMMS',
      'image': 'assets/images/course2.png',
      'isFree': false,
      'rating': 4.5
    },
    {
      'title': 'USS',
      'image': 'assets/images/course3.png',
      'isFree': false,
      'rating': 4.5
    },
     {
      'title': 'MENTAL ABILITY',
      'image': 'assets/images/course1.png',
      'isFree': true,
      'rating': 4.5
    },
    {
      'title': 'NMMS',
      'image': 'assets/images/course2.png',
      'isFree': false,
      'rating': 4.5
    },
    {
      'title': 'USS',
      'image': 'assets/images/course3.png',
      'isFree': false,
      'rating': 4.5
    },
    {
      'title': 'MENTAL ABILITY',
      'image': 'assets/images/course1.png',
      'isFree': true,
      'rating': 4.5
    },
    {
      'title': 'NMMS',
      'image': 'assets/images/course2.png',
      'isFree': false,
      'rating': 4.5
    },
    {
      'title': 'USS',
      'image': 'assets/images/course3.png',
      'isFree': false,
      'rating': 4.5
    },
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CustomBackButton(),
        ),
        SizedBox(width: 10,),
            Text("All Courses"),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            children: [
              Center(
                child: Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                     ...List.generate(courses.length, (index) => MyCourseCard(
                    title: courses[index]['title'], 
                    imagePath: courses[index]['image'], 
                    rating: courses[index]['rating'], 
                    isFree: courses[index]['isFree'], 
                    )
                     )
                  ],
                ),
              ),
            ],
          ) ,
        )
      ),
    );
  }
}