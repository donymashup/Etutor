import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_all_subjects.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_content.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:etutor/features/subscribed_course/widgets/rating_modal.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubscribedCourseClasses extends StatefulWidget {
  final String courseId;
  final String image;
  final String title;
  SubscribedCourseClasses(
      {super.key,
      required this.courseId,
      required this.image,
      required this.title});

  @override
  State<SubscribedCourseClasses> createState() =>
      _SubscribedCourseOverviewState();
}

// class CourseOverview {
//   String title;
//   String subtitle;
//   String type;
//   void Function() onPressed;

//   CourseOverview({
//     required this.title,
//     required this.subtitle,
//     required this.type,
//     required this.onPressed,
//   });
// }

class _SubscribedCourseOverviewState extends State<SubscribedCourseClasses> {
//  late List<CourseOverview> courseoverview;
  SubcribedCourseProvider subcribedCourseProvider = SubcribedCourseProvider();

  @override
  void initState() {
    super.initState();
    load();

    // courseoverview = [
    //   CourseOverview(
    //     title: "Class 6",
    //     subtitle: "Class 6 subjects",
    //     type: "class",
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const SubscribedCourseAllSubjects(),
    //         ),
    //       );
    //     },
    //   ),
    //   CourseOverview(
    //     title: "Class 7",
    //     subtitle: "Class 7 subjects",
    //     type: "class",
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const SubscribedCourseAllSubjects(),
    //         ),
    //       );
    //     },
    //   ),
    //   CourseOverview(
    //     title: "Course Contents",
    //     subtitle: "Tap to view all other resources related to this course",
    //     type: "folder",
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const SubscribedCourseContent(),
    //         ),
    //       );
    //     },
    //   ),
    // ];
  }

  Future<void> load() async {
    await context
        .read<SubcribedCourseProvider>()
        .fetchCourseClasses(context: context, courseid: widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    subcribedCourseProvider = context.watch<SubcribedCourseProvider>();
   
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body:  subcribedCourseProvider.isLoading 
      ? Center(child: Lottie.asset("assets/lottie/lottieloading1.json"))
    :SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                // Container(
                //   height: 300,
                //   width: double.infinity,
                //   decoration:  BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage(widget.image),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Container(
                  height: 300,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomBackButton(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 260),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView.builder(
                        itemCount:
                            subcribedCourseProvider.courseClasses!.data!.length,
                        itemBuilder: (context, index) {
                          final classlist = subcribedCourseProvider
                              .courseClasses!.data![index];
                          return CourseCard(
                            packageClassId:classlist.packageClassId ?? '',  
                            className: classlist.className ?? '',
                            classDescription: classlist.classDescription ?? '',
                            // type: courseoverview[index].type,
                            // onPressed: courseoverview[index].onPressed,
                          );
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        backgroundColor: AppColor.secondaryColor,
                        onPressed: () {
                          showRatingDialog(context);
                        },
                        child: const Icon(Icons.star, color: Colors.white),
                      ),
                    ),
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
