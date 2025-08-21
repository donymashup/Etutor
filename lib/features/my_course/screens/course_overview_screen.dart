import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/my_course/provider/course_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseOverviewScreen extends StatefulWidget {
  const CourseOverviewScreen({super.key});

  @override
  State<CourseOverviewScreen> createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverviewScreen> {
CourseDetailsProvider courseDetailsProvider = CourseDetailsProvider();

  @override
  Widget build(BuildContext context) {
    courseDetailsProvider = context.watch<CourseDetailsProvider>();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text("Class 06 Foundation 25-26",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  Text(courseDetailsProvider.courseDetails.name ??'',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  Text(courseDetailsProvider.courseDetails.level ??'',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Text("${courseDetailsProvider.courseDetails.price} rs",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 10),
                  Text( courseDetailsProvider.package.description ?? '',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,),textAlign: TextAlign.justify,),
                ],
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}