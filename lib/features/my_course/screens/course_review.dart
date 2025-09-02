import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseReview extends StatelessWidget {
  const CourseReview({super.key});

  @override
  Widget build(BuildContext context) {
    final courseDetailsProvider = context.watch<CourseDetailsProvider>();

    final reviews = courseDetailsProvider.reviews;

    return Container(
      color: AppColor.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: reviews.isEmpty
          ? Center(
              child: Text(
                "No reviews available",
                style: TextStyle(
                  fontSize: 16, 
                  color: AppColor.greyAppBar,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return TestimonialCard(
                  username: review.userName ?? '',
                  description: review.comment ?? '',
                  userimage: review.image ?? '',
                  rating: review.rating ?? '',
                );
              },
            ),
    );
  }
}
