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
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "My Courses",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Container(
                    width: 350,
                    child: Divider(
                      color: AppColor.greyStroke,
                      thickness: 1.5,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: FeatureButton(
                        icon: Icons.view_timeline,
                        text: 'Timeline',
                        backgroundColor: AppColor.primaryColor,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FeatureButton(
                        icon: Icons.bar_chart,
                        text: 'Performance Index',
                        backgroundColor: AppColor.secondaryColor,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),



            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Explore the world of Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 105, // 69 (image height) + 24 (padding)
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: infoCardImages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final imagePath = infoCardImages[index];
                    return Container(
                      width: 120, // 93 (image width) + padding
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColor.primaryColor.withOpacity(0.5)),
                        boxShadow: [
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
                        width: 99,
                        height: 75,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Test Your Knowledge",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 105, // 69 (image height) + 24 (padding)
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: testCardImages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final imagePath = testCardImages[index];
                    return Container(
                      width: 120, // 93 (image width) + padding
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColor.primaryColor.withOpacity(0.5)),
                        boxShadow: [
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
                        width: 99,
                        height: 75,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
