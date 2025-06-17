import 'package:etutor/features/home/widgets/mock_courses.dart';
import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/home/widgets/category_button.dart';
import 'package:etutor/features/home/widgets/courses_list.dart';
import 'package:etutor/features/home/widgets/popular_courseslist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Card
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                      bottom: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile and Notification Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/smriti1.jpeg'),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Holla, Yukihira!",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Ready to learn something today?",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/gpt (2).png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.notifications,
                                        color: Colors.black),
                                  ),
                                  Positioned(
                                    right: 6,
                                    top: 6,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: "Search Course here",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

             
              const SizedBox(height: 0),

              const CategoryButtonList(),

              const SizedBox(height: 0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Active Courses(65)",
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See more",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    CoursesList(
                      imagePath: 'assets/images/course1.png',
                      rating: 4.5,
                      title: 'Class 06 Foundation 25-26',
                    ),
                    CoursesList(
                      imagePath: 'assets/images/course2.png',
                      rating: 4.5,
                      title: 'Class 07 Foundation 25-26',
                    ),
                    CoursesList(
                      imagePath: 'assets/images/course3.png',
                      rating: 4.5,
                      title: 'Class 08 Foundation 25-26',
                    ),
                    CoursesList(
                      imagePath: 'assets/images/course4.png',
                      rating: 4.5,
                      title: 'Class 09 Foundation 25-26',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Popular Courses",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    PopularCoursesList(
                      imagePath: 'assets/images/course4.png',
                      rating: 4.5,
                      title: 'Class 08 Foundation 25-26',
                    ),
                    PopularCoursesList(
                      imagePath: 'assets/images/course3.png',
                      rating: 4.5,
                      title: 'Mental Ability 25-26',
                    ),
                    PopularCoursesList(
                      imagePath: 'assets/images/course2.png',
                      rating: 4.5,
                      title: 'Class 08 Foundation 25-26',
                    ),
                    PopularCoursesList(
                      imagePath: 'assets/images/course1.png',
                      rating: 4.5,
                      title: 'Class 07 Foundation 25-26',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Mock Courses",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 190,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    MockCoursesList(
                      imagePath: 'assets/images/course2.png',
                      rating: 4.5,
                      title: 'Class 08 Foundation 25-26',
                    ),
                    MockCoursesList(
                      imagePath: 'assets/images/course1.png',
                      rating: 4.5,
                      title: 'Mental Ability 25-26',
                    ),
                    MockCoursesList(
                      imagePath: 'assets/images/course4.png',
                      rating: 4.5,
                      title: 'Class 08 Foundation 25-26',
                    ),
                    MockCoursesList(
                      imagePath: 'assets/images/course3.png',
                      rating: 4.5,
                      title: 'Class 07 Foundation 25-26',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
