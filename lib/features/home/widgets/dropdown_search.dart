import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
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

// navation when the course is selected
void _navigateToCourseDetails(String courseName) async{
  final selectedCourse = context.watch<LoginProvider>().classes.firstWhere(
    (course) => course.name == courseName,
    orElse: () => throw Exception('Course not found: $courseName'),
  );
 final homepageProvider = Provider.of<HomepageProvider>(context, listen: false);
 final isSubscribed = await homepageProvider.iscourseSubscribed(context, selectedCourse.id ?? "");
 if (!context.mounted) return;
      final subcribedCourseProvider = context.read<SubcribedCourseProvider>();
      await subcribedCourseProvider.fetchCourseClasses(context: context, courseid: selectedCourse.id ?? "");
      final courseimage =subcribedCourseProvider.courseClasses!.data!.first.classImage;
      final coursetitle = subcribedCourseProvider.courseClasses!.data!.first.className;
      isSubscribed ? Navigator.push(
          context,
           MaterialPageRoute(builder: (_) => SubscribedCourseClasses(courseId: selectedCourse.id ?? "", image: courseimage!, title: coursetitle!)),
           )     
           : 
           Navigator.push(
            context,
            MaterialPageRoute(builder: (_) =>  CourseDetailsScreen(courseId: selectedCourse.id ?? "",)),
          );
}


  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body:
       Padding(
        padding: EdgeInsets.all(16.0),
        child:
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
              child: DropdownSearch<String>(
             items: context.watch<LoginProvider>().classes.map((classmodel) => classmodel.name ?? "")
                                  .toList(),
                selectedItem: selectedClass,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedClass = newValue;
                  });
                  _navigateToCourseDetails(selectedClass!);
                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: "Type to search...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  itemBuilder: (context, item, isSelected) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        item,
                        style: TextStyle(
                        ),
                      ),
                    );
                  },
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "Search Course here",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
                filterFn: (item, filter) {
                  return item.toLowerCase().contains(filter.toLowerCase());
                },
              ),
            ),
     ),
   );
  }
}