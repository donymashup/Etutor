import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/screens/gk_post_screen.dart';
import 'package:etutor/features/my_course/screens/gk_vedios.dart';
import 'package:etutor/features/my_course/widgets/feature_button.dart';
import 'package:etutor/features/my_course/widgets/mycoursecard.dart';
import 'package:etutor/features/my_course/widgets/nomycourse.dart';
import 'package:etutor/features/performace_index/screens/performance_index_screen.dart';
import 'package:etutor/features/my_course/widgets/my_course_listview.dart';
import 'package:etutor/features/quiz/screen/new_test_page.dart';
import 'package:etutor/features/quiz/screens/quiz_instruction_screen.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_overview.dart';
import 'package:etutor/features/timeline/screens/timeline_screen.dart';
import 'package:flutter/material.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  bool isGrid = true;

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
  ];

  final List<String> infoCardImages = const [
    'assets/images/qburious.png',
    'assets/images/qouteoftheday.png',
    'assets/images/sciencetoday.png',
    'assets/images/ilovephysics.png',
    'assets/images/fallinlovephysics.png',
    'assets/images/techtoday.png',
  ];

  final List<String> testCardImages = const [
    'assets/images/targetupsc.png',
    'assets/images/etutortest.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Icon button
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top:  10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My Courses",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(isGrid ? Icons.view_list : Icons.grid_view),
                      onPressed: () {
                        setState(() {
                          isGrid = !isGrid;
                        });
                      },
                    )
                  ],
                ),
              ),

              /// Courses
              courses.isEmpty
                  ? const Center(child: nomycourse())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: isGrid
                          ? Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(courses.length, (index) {
                                final course = courses[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SubscribedCourseOverview(),
                                      ),
                                    );
                                  },
                                  child: MyCourseCard(
                                    imgHeight:
                                        MediaQuery.of(context).size.width *
                                            0.25,
                                    title: course['title'],
                                    imagePath: course['image'],
                                    rating: course['rating'],
                                    isFree: course['isFree'],
                                  ),
                                );
                              }),
                            )
                          : MyCourseListView(courses: courses),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Center(
                  child: Divider(
                    color: AppColor.greyStroke,
                    thickness: 1.5,
                    height: 20,
                  ),
                ),
              ),

              /// Feature Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: FeatureButton(
                        icon: Icons.view_timeline,
                        text: 'Timeline',
                        backgroundColor: AppColor.primaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TimelineScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FeatureButton(
                        icon: Icons.bar_chart,
                        text: 'Performance Index',
                        backgroundColor: AppColor.secondaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PerformanceIndexScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Explore Info Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "Explore the world of Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 135,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: infoCardImages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final imagePath = infoCardImages[index];
                    return GestureDetector(
                      onTap: () {
                      // Add navigation logic for each info card here
                      switch (index) {
                        case 0:
                        // Navigate to Qburious page
                        Navigator.push(context, MaterialPageRoute(builder: (_) => GkPostScreen()));
                        break;
                        case 1:
                        // Navigate to Quote of the Day page
                        Navigator.push(context, MaterialPageRoute(builder: (_) => GkVedios()));
                        break;
                        case 2:
                        // Navigate to Science Today page
                        Navigator.push(context, MaterialPageRoute(builder: (_) => GkPostScreen()));
                        break;
                        case 3:
                        // Navigate to I Love Physics page
                        Navigator.push(context, MaterialPageRoute(builder: (_) => GkVedios()));
                        break;
                        case 4:
                        // Navigate to Fall in Love with Physics page
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => FallInLovePhysicsScreen()));
                        break;
                        case 5:
                        // Navigate to Tech Today page
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => TechTodayScreen()));
                        break;
                        default:
                        break;
                      }
                      },
                      child: Container(
                      width: MediaQuery.of(context).size.width * 0.15 < 120
                        ? 120
                        : MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColor.primaryColor.withOpacity(0.5)),
                        boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              /// Test Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "Test Your Knowledge",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 135,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: testCardImages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final imagePath = testCardImages[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizInstructionPage())),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15 < 120
                            ? 120
                            : MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColor.primaryColor.withOpacity(0.5)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
