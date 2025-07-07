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
      'title': ' International General Knowledge Olympiad (IGKO)',
      'image': 'assets/images/oly2.jpg',
      'isFree': false,
      'rating': 4.6,
    },
    {
      'title': 'International Commerce Olympiad (ICO)',
      'image': 'assets/images/oly3.jpeg',
      'isFree': false,
      'rating': 4.4,
    },
    {
      'title': 'International English Olympiad (IEO)',
      'image': 'assets/images/oly4.jpg',
      'isFree': false,
      'rating': 4.7,
    },

    {
      'title': 'Mental Ability 25-26',
      'image': 'assets/images/oly8.jpg',
      'isFree': true,
      'rating': 4.8,
    },
    {
      'title': ' International Hindi Olympiad (IEO)',
      'image': 'assets/images/oly11.jpg',
      'isFree': false,
      'rating': 4.3,
    },
     {
      'title': 'International Social Studies Olympiad (ISSO)',
      'image': 'assets/images/oly1.jpg',
      'isFree': false,
      'rating': 4.5,
    },
    { 
      'title': 'Math Olympiad 25-26',
      'image': 'assets/images/oly9.jpg',
      'rating': 4.6,
      'isFree': true,
    },
    {
      'title': 'Spell Bee (CSB) ',
      'image': 'assets/images/oly10.jpg',
      'rating': 4.9,
      'isFree': false,
    },
    {
      'title': 'National Interactive Maths Olympiad [NIMO]',
      'image': 'assets/images/oly6.jpeg',
      'isFree': true,
      'rating': 4.9,
    },
    {
      'title': 'International Mathematics Olympiad (IMO)',
      'image': 'assets/images/oly5.webp',
      'isFree': false,
      'rating': 4.8,
    },
    {
      'image': 'assets/images/oly7.png',
      'title': 'National Science Olympiad (NSO)',
      'isFree': true,
      'rating': 4.6,
    },
    {
      'title': 'English Smart Series',
      'image': 'assets/images/oly6.jpeg',
      'isFree': true,
      'rating': 4.3,
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