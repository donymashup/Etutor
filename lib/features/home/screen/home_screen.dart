import 'package:etutor/features/my_course/screens/course_details_screen.dart';
import 'package:etutor/features/notification/screens/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/home/widgets/category_button.dart';
import 'package:etutor/features/home/widgets/courses_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> activeCourses = [
    {
      'imagePath': 'assets/images/course1.png',
      'title': 'Class 06 Foundation 25-26',
      'rating': 4.5,
    },
    {
      'imagePath': 'assets/images/course2.png',
      'title': 'Class 07 Foundation 25-26',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/course3.png',
      'title': 'Class 08 Foundation 25-26',
      'rating': 4.4,
    },
    {
      'imagePath': 'assets/images/course4.png',
      'title': 'Class 09 Foundation 25-26',
      'rating': 4.7,
    },
  ];

  final List<Map<String, dynamic>> popularCourses = [
    {
      'imagePath': 'assets/images/course4.png',
      'title': 'Mental Ability 25-26',
      'rating': 4.8,
    },
    {
      'imagePath': 'assets/images/course3.png',
      'title': 'Math Olympiad 25-26',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/course2.png',
      'title': 'Science Booster',
      'rating': 4.9,
    },
    {
      'imagePath': 'assets/images/course1.png',
      'title': 'English Smart Series',
      'rating': 4.3,
    },
  ];

  final List<Map<String, dynamic>> mockCourses = [
    {
      'imagePath': 'assets/images/course3.png',
      'title': 'Mental Ability 25-26',
      'rating': 4.8,
    },
    {
      'imagePath': 'assets/images/course1.png',
      'title': 'Math Olympiad 25-26',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/course2.png',
      'title': 'Science Booster',
      'rating': 4.9,
    },
    {
      'imagePath': 'assets/images/course4.png',
      'title': 'English Smart Series',
      'rating': 4.3,
    },
  ];

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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationPage(),
                                        ),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.notifications,
                                          color: Colors.black),
                                    ),
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

              const CategoryButtonList(),

              // --- Active Courses ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Active Courses(${activeCourses.length})",
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
                height: MediaQuery.of(context).size.width * 0.22 + 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: activeCourses.length,
                  itemBuilder: (context, index) {
                    final course = activeCourses[index];
                    // return CoursesList(
                    //   imagePath: course['imagePath'],
                    //   rating: course['rating'],
                    //   title: course['title'],
                    // );

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailsScreen(),
                          ),
                        );
                      },
                      child: CoursesList(
                        imagePath: course['imagePath'],
                        rating: course['rating'],
                        title: course['title'],
                      ),
                    );
                  },
                ),
              ),

              // --- Popular Courses ---
              const SizedBox(height: 20),
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
                height: MediaQuery.of(context).size.width * 0.22 + 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: popularCourses.length,
                  itemBuilder: (context, index) {
                    final course = popularCourses[index];
                    // return CoursesList(
                    //   imagePath: course['imagePath'],
                    //   rating: course['rating'],
                    //   title: course['title'],
                    // );

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailsScreen(),
                          ),
                        );
                      },
                      child: CoursesList(
                        imagePath: course['imagePath'],
                        rating: course['rating'],
                        title: course['title'],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // --- Mock Courses ---
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
                height: MediaQuery.of(context).size.width * 0.22 + 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: mockCourses.length,
                  itemBuilder: (context, index) {
                    final course = mockCourses[index];
                    // return CoursesList(
                    //   imagePath: course['imagePath'],
                    //   rating: course['rating'],
                    //   title: course['title'],
                    // );
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseDetailsScreen(),
                          ),
                        );
                      },
                      child: CoursesList(
                        imagePath: course['imagePath'],
                        rating: course['rating'],
                        title: course['title'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
