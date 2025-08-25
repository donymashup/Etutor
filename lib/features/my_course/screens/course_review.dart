import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:etutor/features/my_course/widgets/testimonial_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseReview extends StatefulWidget {
  const CourseReview({super.key});

  @override
  State<CourseReview> createState() => _CourseReviewState();
}

class _CourseReviewState extends State<CourseReview> {
    CourseDetailsProvider courseDetailsProvider = CourseDetailsProvider();

  @override
  Widget build(BuildContext context) {
    courseDetailsProvider = context.watch<CourseDetailsProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Expanded(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: courseDetailsProvider.reviews.length,
                    itemBuilder: (context, index)
                    { 
                      final reviews = courseDetailsProvider.reviews[index];
                       return TestimonialCard(
                        username: reviews.userName ?? '',
                        description: reviews.comment ?? '',
                        userimage: reviews.image ?? '',
                        rating: reviews.rating ?? '',);
                    }
                   ),
              ),
              SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
