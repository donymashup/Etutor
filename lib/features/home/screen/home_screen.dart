import 'package:etutor/features/drawer/screens/drawer.dart';
import 'package:etutor/features/home/screen/see_more_courses.dart';
import 'package:etutor/features/my_course/screens/course_details_screen.dart';
import 'package:etutor/features/notification/screens/notification_page.dart';
import 'package:etutor/features/profile/screens/profile.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> activeCourses = [
    {
      'imagePath': 'assets/images/course1.png',
      'title': 'International Social Studies Olympiad (ISSO)',
      'rating': 4.5,
    },
    {
      'imagePath': 'assets/images/course2.png',
      'title': ' International General Knowledge Olympiad (IGKO)',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/course3.png',
      'title': 'International Commerce Olympiad (ICO)',
      'rating': 4.4,
    },
    {
      'imagePath': 'assets/images/course4.png',
      'title': 'International English Olympiad (IEO)',
      'rating': 4.7,
    },
  ];

  final List<Map<String, dynamic>> popularCourses = [
    {
      'imagePath': 'assets/images/course4.png',
      'title': 'International Mathematics Olympiad (IMO)',
      'rating': 4.8,
    },
    {
      'imagePath': 'assets/images/course3.png',
      'title': 'National Science Olympiad (NSO)',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/course2.png',
      'title': 'National Interactive Maths Olympiad [NIMO]',
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
      'title': 'Spell Bee (CSB) ',
      'rating': 4.9,
    },
    {
      'imagePath': 'assets/images/course4.png',
      'title': ' International English Olympiad (IEO)',
      'rating': 4.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const SideDrawer(),
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
                          Expanded(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Profile(),
                                      ),
                                    );
                                  },
                                  child: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                    AssetImage('assets/images/smriti1.jpeg'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  // Add this to prevent text overflow
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Holla, Yukihira!",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow:
                                            TextOverflow.ellipsis, // optional
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Ready to learn something today?",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                        overflow:
                                            TextOverflow.ellipsis, // optional
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                    child: Icon(Icons.notifications,
                                        color: Colors.white),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
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
                             IconButton(
                              icon: Image.asset(
                                "assets/icons/menu.png",
                                width: 24,
                                height: 24,
                              ),
                              onPressed: () {
                                // Implement menu functionality
                                _scaffoldKey.currentState?.openEndDrawer();
                              },
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
                        child: Row(
                          children: [
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.search),
                                  hintText: "Search Course here",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            
                             Container(
                                width: 40,
                                height: 40,
                               // margin: const EdgeInsets.only(right: 12),
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

                          ],
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
                    TextButton(
                      onPressed: () =>  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SeeMoreCourses(),
                          ),
                        ),
                      child: Text("See More",style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
