import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/widgets/course_card.dart';
import 'package:etutor/features/subscribed_course/widgets/course_contents._card.dart';
import 'package:etutor/features/subscribed_course/widgets/listview_shimmer_loader.dart';
import 'package:etutor/features/subscribed_course/widgets/rating_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubscribedCourseClasses extends StatefulWidget {
  final String courseId;
  final String image;
  final String title;
  const SubscribedCourseClasses({
    super.key,
    required this.courseId,
    required this.image,
    required this.title,
  });

  @override
  State<SubscribedCourseClasses> createState() =>
      _SubscribedCourseOverviewState();
}

class _SubscribedCourseOverviewState extends State<SubscribedCourseClasses> {
  SubcribedCourseProvider subcribedCourseProvider = SubcribedCourseProvider();

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<SubcribedCourseProvider>().fetchCourseClasses(
      context: context,
      courseid: widget.courseId,
    );
  });
}


  @override
  Widget build(BuildContext context) {
    subcribedCourseProvider = context.watch<SubcribedCourseProvider>();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
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
                  subcribedCourseProvider.isClassLoading
    ? const ListviewShimmerLoader()
    : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: subcribedCourseProvider.courseClasses == null ||
                subcribedCourseProvider.courseClasses!.data == null ||
                subcribedCourseProvider.courseClasses!.data!.isEmpty
            ? const Center(child: Text('No Classes'))
            : ListView.builder(
                itemCount: subcribedCourseProvider.courseClasses!.data!.length,
                itemBuilder: (context, index) {
                  final classlist = subcribedCourseProvider.courseClasses!.data![index];
                  return Column(
                    children: [
                      CourseCard(
                        packageClassId: classlist.packageClassId ?? '',
                        className: classlist.className ?? '',
                        classDescription: classlist.classDescription ?? '',
                      ),
                      ContentsCard(courseid: widget.courseId),
                    ],
                  );
                },
              ),
      ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        backgroundColor: AppColor.secondaryColor,
                        onPressed: () {
                          showRatingDialog(context, widget.courseId);
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
