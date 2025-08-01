import 'package:etutor/features/home/model/user_details_model.dart';
import 'package:etutor/features/home/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/drawer/screens/drawer.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/home/screen/see_more_courses.dart';
import 'package:etutor/features/my_course/screens/course_details_screen.dart';
import 'package:etutor/features/notification/screens/notification_page.dart';
import 'package:etutor/features/profile/screens/profile.dart';
import 'package:etutor/features/home/widgets/category_button.dart';
import 'package:etutor/features/home/widgets/courses_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserDetailsProvider userProvider = UserDetailsProvider();

  @override
  void initState() {
    super.initState();
    _userDetails();
  }

  Future<void> _userDetails() async {
    final userDetailsProvider  = context.read<UserDetailsProvider>();
    await userDetailsProvider.loadUserDetails(context);
  }

  final List<Map<String, dynamic>> activeCourses = [
    {
      'imagePath': 'assets/images/oly1.jpg',
      'title': 'International Social Studies Olympiad (ISSO)',
      'rating': 4.5,
    },
    {
      'imagePath': 'assets/images/oly2.jpg',
      'title': 'International General Knowledge Olympiad (IGKO)',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/oly3.jpeg',
      'title': 'International Commerce Olympiad (ICO)',
      'rating': 4.4,
    },
    {
      'imagePath': 'assets/images/oly4.jpg',
      'title': 'International English Olympiad (IEO)',
      'rating': 4.7,
    },
  ];

  final List<Map<String, dynamic>> popularCourses = [
    {
      'imagePath': 'assets/images/oly6.jpeg',
      'title': 'National Interactive Maths Olympiad [NIMO]',
      'rating': 4.9,
    },
    {
      'imagePath': 'assets/images/oly5.webp',
      'title': 'International Mathematics Olympiad (IMO)',
      'rating': 4.8,
    },
    {
      'imagePath': 'assets/images/oly7.png',
      'title': 'National Science Olympiad (NSO)',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/oly6.jpeg',
      'title': 'English Smart Series',
      'rating': 4.3,
    },
  ];

  final List<Map<String, dynamic>> mockCourses = [
    {
      'imagePath': 'assets/images/oly8.jpg',
      'title': 'Mental Ability 25-26',
      'rating': 4.8,
    },
    {
      'imagePath': 'assets/images/oly11.jpg',
      'title': 'International Hindi Olympiad (IEO)',
      'rating': 4.3,
    },
    {
      'imagePath': 'assets/images/oly9.jpg',
      'title': 'Math Olympiad 25-26',
      'rating': 4.6,
    },
    {
      'imagePath': 'assets/images/oly10.jpg',
      'title': 'Spell Bee (CSB)',
      'rating': 4.9,
    },
  ];

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserDetailsProvider>(context, listen: true);

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
              // Top Profile + Search Section
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
                                      MaterialPageRoute(builder: (_) => const Profile()),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: ((userProvider.userDetails.data ?? Data()).image != null && ((userProvider.userDetails.data ?? Data()).image ?? "").isNotEmpty)
                                        ? NetworkImage((userProvider.userDetails.data ?? Data()).image ?? "")
                                        : const AssetImage('assets/images/default_user_image.png') as ImageProvider,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.watch<UserDetailsProvider>().isLoading
                                            ? "Loading..."
                                            : (userProvider.userDetails.data ?? Data()).firstName != null
                                                ? "Hello, ${(userProvider.userDetails.data ?? Data()).firstName}!"
                                                : "Hello, User!",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        "Ready to learn something today?",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
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
                                        MaterialPageRoute(builder: (_) => const NotificationPage()),
                                      );
                                    },
                                    child: const Icon(Icons.notifications, color: Colors.white),
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
                                icon: Image.asset("assets/icons/menu.png", width: 24, height: 24),
                                onPressed: () {
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
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/gpt (2).png'),
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
               CarouselScreen(),
               // Popular Courses
              sectionHeader("Popular Courses"),
              courseList(popularCourses),
             SizedBox(height: 10,)   ,    
             const CategoryButtonList(),

              // Active Courses
              sectionHeader("Active Courses (${activeCourses.length})", () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SeeMoreCourses()));
              }),   
               courseList(activeCourses), 
             
              // // Mock Courses
              // sectionHeader("Mock Courses"),
              // courseList(mockCourses),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(String title, [VoidCallback? onSeeMore]) {
    return Padding(
       padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onSeeMore != null)
                      TextButton(
                        onPressed: onSeeMore,
                        child: Text(
                          "See More",
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )

        ],
      ),
    );
  }

  Widget courseList(List<Map<String, dynamic>> courses) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.22 + 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CourseDetailsScreen()),
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
    );
  }
}
