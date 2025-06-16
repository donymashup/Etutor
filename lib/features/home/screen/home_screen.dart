import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/home/widgets/category_button.dart';
import 'package:etutor/features/home/widgets/courses_list.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_card.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            // Top Card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24), bottom: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile and Notification Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Profile
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  'assets/images/smriti1.jpeg'), // Replace with your image
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

                        // Notification with dot
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

                    const SizedBox(height: 20),

                    // Search Bar
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

            // Categories Row
            const CategoryButtonList(),

            SizedBox(height: 05),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
              height: 170, // enough for image + stars
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  CoursesList(
                    imagePath: 'assets/images/smriti1.jpeg',
                    rating: 4.5,
                  ),
                  CoursesList(
                    imagePath: 'assets/images/smriti1.jpeg',
                    rating: 4.5,
                  ),
                  CoursesList(
                    imagePath: 'assets/images/smriti1.jpeg',
                    rating: 4.5,
                  ),
                  CoursesList(
                    imagePath: 'assets/images/smriti1.jpeg',
                    rating: 4.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
