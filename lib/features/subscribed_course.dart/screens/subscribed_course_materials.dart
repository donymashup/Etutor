import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/subscribed_course.dart/widgets/course_card.dart';
import 'package:flutter/material.dart';

class SubscribedCourseMaterials extends StatefulWidget {
  const SubscribedCourseMaterials({super.key});

  @override
  State<SubscribedCourseMaterials> createState() =>
      _SubscribedCourseMaterialsState();
}

class Materials {
  String title;
  String subtitle;
  IconData icon;
  Color iconBgcolor;
  Color iconcolor;
  void Function() onPressed;

  Materials(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.iconcolor,
      required this.iconBgcolor,
      required this.onPressed});
}

class _SubscribedCourseMaterialsState extends State<SubscribedCourseMaterials> {
  List<Materials> materials = [
    Materials(
      title: "Chapter 1 Notes", 
      subtitle: "Tap to view this pdf", 
      icon: Icons.picture_as_pdf, 
      iconcolor: AppColor.lightRedCardBackground, 
      iconBgcolor: AppColor.redBarGraph, 
      onPressed: (){}),
      Materials(
      title: "Chapter 2 Notes", 
      subtitle: "Tap to view this pdf", 
      icon: Icons.picture_as_pdf, 
      iconcolor: AppColor.lightRedCardBackground, 
      iconBgcolor: AppColor.redBarGraph, 
      onPressed: (){}),
      Materials(
      title: "Figure 2.9", 
      subtitle: "Tap to view this image", 
      icon: Icons.image, 
      iconcolor: AppColor.lightGreenCardBackground, 
      iconBgcolor: AppColor.greenBarGraph, 
      onPressed: (){}),
      // Materials(
      // title: "Figure 2.9", 
      // subtitle: "Tap to view this image", 
      // icon: Icons.image, 
      // iconcolor: AppColor.lightGreenCardBackground, 
      // iconBgcolor: AppColor.greenBarGraph, 
      // onPressed: (){}),Materials(
      // title: "Figure 9.9", 
      // subtitle: "Tap to view this image", 
      // icon: Icons.image, 
      // iconcolor: AppColor.lightGreenCardBackground, 
      // iconBgcolor: AppColor.greenBarGraph, 
      // onPressed: (){}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "Assignments",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: materials.length,
                  itemBuilder: (context, index) => CourseCard(
                      title: materials[index].title,
                      subtitle: materials[index].subtitle,
                      icon: materials[index].icon,
                      iconBgColor: materials[index].iconBgcolor,
                      onPressed: materials[index].onPressed,
                      iconColor: materials[index].iconcolor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
