import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/my_course/screens/course_curriculum.dart';
import 'package:etutor/features/my_course/screens/course_overview_screen.dart';
import 'package:etutor/features/my_course/screens/course_review.dart';
import 'package:etutor/features/payment/screen/checkout_screen.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Details"),
        backgroundColor: AppColor.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children:[ 
                  Container(
                  height: MediaQuery.of(context).size.width * .5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/course2.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: CustomBackButton(),
                //   ),
                // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.greyAppBar)),
                child: TabBar(
                  controller: _tabcontroller,
                  tabs: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Tab(text: "Overview"),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(text: "Curriculum"),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(text: "Reviews"),
                    )),
                  ],
                  labelColor: AppColor.whiteColor,
                  unselectedLabelColor: AppColor.blackColor,
                  dividerHeight: 0,
                  indicatorColor: AppColor.blackColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      color: AppColor.blackColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Expanded(
              child: Stack(children: [
                TabBarView(controller: _tabcontroller,
                 children: [
                  CourseOverviewScreen(),
                  CourseCurriculum(),
                  CourseReview(),
                ]),
              ]),
            ),
          ],
        ),
        Positioned(
            bottom: 0,
            child: Container(
              color: AppColor.whiteColor,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: CustomButton(
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      );
                    },
                    text: "Enroll now",
                    buttoncolor: AppColor.primaryColor,textColor: AppColor.whiteColor,),
              ),
            ))
      ])),
    );
  }
}
