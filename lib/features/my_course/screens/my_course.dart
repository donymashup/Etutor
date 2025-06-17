import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/widgets/feature_button.dart';
import 'package:etutor/features/my_course/widgets/mycoursecard.dart';
import 'package:flutter/material.dart';

class MyCoursePage extends StatelessWidget {
  const MyCoursePage({super.key});

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  "My Courses",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final course = courses[index];
                    return MyCourseCard(
                      title: course['title'],
                      imagePath: course['image'],
                      rating: course['rating'],
                      isFree: course['isFree'],
                    );
                  },
                  childCount: courses.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 2.5,
                ),
              ),

            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  width:350, // Reduced width
                  child: Divider(
                    color: AppColor.greyStroke,
                    thickness: 1.5,
                    height: 20,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
                child: Padding(padding: const EdgeInsets.all(20),
                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        FeatureButton(
                            icon: Icons.view_timeline,
                            text: 'Timeline',
                            backgroundColor: AppColor.primaryColor,
                            onPressed: () {
                            },
                        ),
                        FeatureButton(
                            icon: Icons.bar_chart,
                            text: 'Performance Index',
                            backgroundColor: AppColor.secondaryColor,
                            onPressed: () {
                            },
                        ),
                    ],
                 ),),
            )


            ],
          ),
        ),
      ),
    );
  }
}
