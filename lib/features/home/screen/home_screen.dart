import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/widgets/grid_shimmer_loader.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/home/model/user_details_model.dart';
import 'package:etutor/features/home/provider/homepage_provider.dart';
import 'package:etutor/features/home/widgets/carousel.dart';
import 'package:etutor/features/home/widgets/course_grid.dart';
import 'package:etutor/features/home/widgets/dropdown_search.dart';
import 'package:etutor/features/home/widgets/horizondal_shimmer_loader.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_classes.dart';
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
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserDetailsProvider userProvider = UserDetailsProvider();
  HomepageProvider homeProvider = HomepageProvider();

  @override
  void initState() {
    super.initState();
    _userDetails();
  }

  Future<void> _userDetails() async {
    final homepageProvider = context.read<HomepageProvider>();
    homepageProvider.makeLoadingTrue();
    final userDetailsProvider = context.read<UserDetailsProvider>();
    await userDetailsProvider.loadUserDetails(context);
    await homepageProvider.popularCourses(context);
    await context.read<LoginProvider>().dropDownOptions(context);
    await homepageProvider.categoryHeader(context);
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserDetailsProvider>(context, listen: true);
    homeProvider = Provider.of<HomepageProvider>(context, listen: true);
    final catIndex = homeProvider.selectedIndex;
    //  String? selectedCourse;

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
                                      MaterialPageRoute(
                                          builder: (_) => const Profile()),
                                    );
                                    _userDetails();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: _buildProfileAvatar(userProvider),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context
                                                .watch<UserDetailsProvider>()
                                                .isLoading
                                            ? "Loading..."
                                            : (userProvider.userDetails.data ??
                                                            Data())
                                                        .firstName !=
                                                    null
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
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const NotificationPage()),
                                      );
                                    },
                                    child: const Icon(Icons.notifications,
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
                                icon: Image.asset("assets/icons/menu.png",
                                    width: 24, height: 24),
                                onPressed: () {
                                  _scaffoldKey.currentState?.openEndDrawer();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      //search field with ai assistant button
                      SearchableDropdown(),                     
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(16),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       const Expanded(
                      //         child: TextField(
                      //           decoration: InputDecoration(
                      //             icon: Icon(Icons.search),
                      //             hintText: "Search Course here",
                      //             border: InputBorder.none,
                      //           ),
                      //         ),
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (_) =>
                      //                       SearchableDropdown()));
                      //         },
                      //         child: Container(
                      //           width: 40,
                      //           height: 40,
                      //           decoration: const BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             image: DecorationImage(
                      //               image:
                      //                   AssetImage('assets/images/gpt (2).png'),
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // banner images
              CarouselScreen(),

              // Popular Courses
              sectionHeader("Popular Courses"),
              homeProvider.isPopularLoading
                  ? HorizondalShimmerLoader()
                  : courseList(homeProvider.popularCourse
                      .map((data) => {
                            'id': data.id,
                            'name': data.name,
                            'price': data.price,
                            'image': data.image,
                            'discount': data.discount,
                            'likesCount': data.likesCount,
                            'avgStars': data.avgStars,
                            'syllabus': data.syllabus,
                          })
                      .toList()),
              SizedBox(
                height: 10,
              ),

              // category header
              CategoryButtonList(),

              // Active Courses
              sectionHeader(
                  homeProvider.isCategoryHeader
                      ? "Active Courses (0)"
                      : "Active Courses (${(homeProvider.catogryDetails[catIndex].courses ?? []).length})",
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SeeMoreCourses(
                              catIndex: catIndex,
                            )));
              }),
              // courseList(activeCourses),
              homeProvider.isCategoryHeader
                  ? GridShimmeLoader()
                  : CoursesGridWidget(
                      courses:
                          (homeProvider.catogryDetails[catIndex].courses ?? [])
                              .map((data) => {
                                    'id': data.courseDetails?.id,
                                    'name': data.courseDetails?.name,
                                    'price': data.courseDetails?.price,
                                    'image': data.courseDetails?.image,
                                    'discount': data.courseDetails?.discount,
                                    'avgStars': data.avgStars,
                                    'syllabus': data.courseDetails?.syllabus,
                                  })
                              .toList())
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
    if (courses.isEmpty) {
      return SizedBox(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school_outlined, size: 60, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text(
                'No courses available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.22 + 106,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () async {
              final homepageProvider =
                  Provider.of<HomepageProvider>(context, listen: false);
              final isSubscribed = await homepageProvider.iscourseSubscribed(
                  context, course['id']);
              if (!context.mounted) return;
              final subcribedCourseProvider =
                  context.read<SubcribedCourseProvider>();
              await subcribedCourseProvider.fetchCourseClasses(
                  context: context, courseid: course['id']);
              final courseimage =
                  subcribedCourseProvider.courseClasses!.data!.first.classImage;
              final coursetitle =
                  subcribedCourseProvider.courseClasses!.data!.first.className;
              isSubscribed
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SubscribedCourseClasses(
                              courseId: course["id"],
                              image: courseimage!,
                              title: coursetitle!,
                              )),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CourseDetailsScreen(
                                courseId: course["id"],
                              )),
                    );
            },
            child: CoursesList(
              imagePath: course['image'],
              rating: double.tryParse(course['avgStars'].toString()) ?? 0.0,
              title: course['name'],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileAvatar(UserDetailsProvider userProvider) {
    final imageUrl = userProvider.userDetails.data?.image ?? "";

    if (imageUrl.isEmpty) {
      // Default image if user has no profile image
      return const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/default_user_image.png'),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 25,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
        ),
      ),
      errorWidget: (context, url, error) => const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/default_user_image.png'),
      ),
    );
  }
}
