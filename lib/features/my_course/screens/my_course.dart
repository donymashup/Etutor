import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/grid_shimmer_loader.dart';
import 'package:etutor/features/my_course/provider/my_course_provider.dart';
import 'package:etutor/features/my_course/screens/gk_post_screen.dart';
import 'package:etutor/features/my_course/screens/gk_vedios.dart';
import 'package:etutor/features/my_course/widgets/feature_button.dart';
import 'package:etutor/features/my_course/widgets/mycoursecard.dart';
import 'package:etutor/features/my_course/widgets/nomycourse.dart';
import 'package:etutor/features/performace_index/screens/performance_index_screen.dart';
import 'package:etutor/features/my_course/widgets/my_course_listview.dart';
import 'package:etutor/features/quiz/screens/quiz_instruction_screen.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_classes.dart';
import 'package:etutor/features/timeline/screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});
 
  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  bool isGrid = true;
  MyCourseProvider courseProvider = MyCourseProvider();

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
  void initState() {
    super.initState();
    laodCourse();
  }
  
  Future <void> laodCourse() async {
     final mycourseprovider = context.read<MyCourseProvider>();
     await mycourseprovider.subscribedCourses(context);
  }


  @override
  Widget build(BuildContext context) {
  courseProvider = context.watch<MyCourseProvider>();
  

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
              courseProvider.isLoading 
              ? GridShimmeLoader()
              :courseProvider.subscribedCourse.isEmpty
                  ? const Center(child: nomycourse())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: isGrid
                          ? courseProvider.isLoading 
                              ? GridShimmeLoader()
                              :Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(courseProvider.subscribedCourse.length, (index) {
                                final course = courseProvider.subscribedCourse[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.read<MyCourseProvider>().getbatchid(course.batchId ?? '');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                             SubscribedCourseClasses(courseId:course.courseId!,image: course.courseImage!,title: course.courseName!,)
                                      ),
                                    );
                                  },
                                  child: MyCourseCard(
                                    imgHeight:
                                        MediaQuery.of(context).size.width *
                                            0.25,
                                    title: course.courseName ?? "",
                                    imagePath: course.courseImage ?? "",
                                    rating: course.avgStars ?? 0.0,
                                    //isFree: course['isFree'],
                                  ),
                                );
                              }),
                            )
                              : MyCourseListView(
                            courses: courseProvider.subscribedCourse
                              .map((data) => {
                              'id': data.courseId ?? '',
                              'name': data.courseName ?? "",
                              'image': data.courseImage ?? "",
                              'avgStars': data.avgStars ?? "",
                              'enrollmentId': data.enrollmentId ?? "",
                              'packageId': data.packageId ?? "",
                              'batchId': data.batchId ?? "",
                          }).toList()),
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
                      onTap: () {},
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
