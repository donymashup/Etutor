// import 'package:etutor/features/home/provider/homepage_provider.dart';
// import 'package:etutor/features/my_course/screens/course_details_screen.dart';
// import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
// import 'package:etutor/features/subscribed_course/screens/subscribed_course_classes.dart';
// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:provider/provider.dart';

// class SearchableDropdown extends StatefulWidget {
//   @override
//   _SearchableDropdownState createState() => _SearchableDropdownState();
// }

// class _SearchableDropdownState extends State<SearchableDropdown> {
//   String? selectedClass;

// // navation when the course is selected
// void _navigateToCourseDetails(String courseName) async{
//   final course = context.read<HomepageProvider>().catogryDetails[0].courses!
//         .firstWhere(
//           (course) => course.courseDetails?.name == courseName,
//           orElse: () => throw Exception('Course not found'),
//         );
//     final homepageProvider = Provider.of<HomepageProvider>(context, listen: false);
//     final isSubscribed = await homepageProvider.iscourseSubscribed(context, course.courseDetails!.id ?? "");
//     if (!context.mounted) return;
//           final subcribedCourseProvider = context.read<SubcribedCourseProvider>();
//           await subcribedCourseProvider.fetchCourseClasses(context: context, courseid: course.courseDetails!.id ?? "");
//           final courseimage =subcribedCourseProvider.courseClasses!.data!.first.classImage;
//           final coursetitle = subcribedCourseProvider.courseClasses!.data!.first.className;
//           isSubscribed ? Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => SubscribedCourseClasses(courseId: course.courseDetails!.id ?? "", image: courseimage!, title: coursetitle!)),
//               )
//               :
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) =>  CourseDetailsScreen(courseId: course.courseDetails!.id ?? "",)),
//               );
// }
//   @override
//   Widget build(BuildContext context) {
//     return
//        Padding(
//         padding: EdgeInsets.all(0),
//         child:
//             Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//               child: DropdownSearch<String>(
//              items: context.watch<HomepageProvider>().catogryDetails[0].courses!
//             .map((course) => course.courseDetails?.name ?? "")
//             .toList(),
//                 selectedItem: selectedClass,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedClass = newValue;
//                   });
//                   _navigateToCourseDetails(selectedClass!);
//                 },
//                 popupProps: PopupProps.menu(
//                   showSearchBox: true,
//                   searchFieldProps: TextFieldProps(
//                     decoration: InputDecoration(
//                       hintText: "Type to search...",
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   itemBuilder: (context, item, isSelected) {
//                     return Container(
//                       padding: EdgeInsets.all(12),
//                       child: Text(
//                         item,
//                         style: TextStyle(
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 dropdownDecoratorProps: DropDownDecoratorProps(
//                   dropdownSearchDecoration: InputDecoration(
//                     hintText: "Search Course here",
//                     prefixIcon: Icon(Icons.search),
//                     border: InputBorder.none,
//                   ),
//                 ),
//                 filterFn: (item, filter) {
//                   return item.toLowerCase().contains(filter.toLowerCase());
//                 },
//               ),
//             ),
//    );
//   }
// }

import 'package:etutor/features/home/provider/homepage_provider.dart';
import 'package:etutor/features/my_course/screens/course_details_screen.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_classes.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

class SearchableDropdown extends StatefulWidget {
  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  String? selectedClass;

  // Navigation when the course is selected
  void _navigateToCourseDetails(String courseName) async {
    final homepageProvider = context.read<HomepageProvider>();
    if (homepageProvider.catogryDetails.isEmpty ||
        homepageProvider.catogryDetails[0].courses == null ||
        homepageProvider.catogryDetails[0].courses!.isEmpty) {
      return;
    }

    try {
      final course = homepageProvider.catogryDetails[0].courses!.firstWhere(
        (course) => course.courseDetails?.name == courseName,
        orElse: () => throw Exception('Course not found'),
      );

      final isSubscribed = await homepageProvider.iscourseSubscribed(
          context, course.courseDetails!.id ?? "");

      if (!context.mounted) return;

      final subcribedCourseProvider = context.read<SubcribedCourseProvider>();
      await subcribedCourseProvider.fetchCourseClasses(
          context: context, courseid: course.courseDetails!.id ?? "");

      final courseimage =
          subcribedCourseProvider.courseClasses?.data?.first.classImage;
      final coursetitle =
          subcribedCourseProvider.courseClasses?.data?.first.className;

      if (isSubscribed) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SubscribedCourseClasses(
              courseId: course.courseDetails!.id ?? "",
              image: courseimage ?? "",
              title: coursetitle ?? "",
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailsScreen(
              courseId: course.courseDetails!.id ?? "",
            ),
          ),
        );
      }
    } catch (e) {
      print('Error navigating to course details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageProvider>(
      builder: (context, homepageProvider, child) {
        if (homepageProvider.catogryDetails.isEmpty ||
            homepageProvider.catogryDetails[0].courses == null) {
          return Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 12),
                  Text(
                    "Loading courses...",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        // Get the list of courses
        final courseList = homepageProvider.catogryDetails[0].courses!
            .map((course) => course.courseDetails?.name ?? "")
            .where((name) => name.isNotEmpty)
            .toList();

        // If no courses available
        if (courseList.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 12),
                  Text(
                    "No courses available",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(30), // Rounded like screenshot
            ),
            child: DropdownSearch<String>(
              items: courseList,
              selectedItem: selectedClass,
              dropdownButtonProps: DropdownButtonProps(
                icon: Icon(Icons.arrow_drop_down,
                    color: Colors.grey), // Right side arrow
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedClass = newValue;
                });
                if (newValue != null) {
                  _navigateToCourseDetails(newValue);
                }
              },
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: "Type to search...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                itemBuilder: (context, item, isSelected) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Text(item),
                  );
                },
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: "Search Course here...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12), 
                ),
              ),
              filterFn: (item, filter) {
                return item.toLowerCase().contains(filter.toLowerCase());
              },
            ),
          ),
        );
      },
    );
  }
}
