import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/grid_shimmer_loader.dart';
import 'package:etutor/features/auth/provider/login_provider.dart';
import 'package:etutor/features/home/provider/homepage_provider.dart';
import 'package:etutor/features/my_course/screens/course_details_screen.dart';
import 'package:etutor/features/my_course/widgets/mycoursecard.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/subscribed_course/screens/subscribed_course_classes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeMoreCourses extends StatefulWidget {
  final int catIndex;
  const SeeMoreCourses({super.key, required this.catIndex});

  @override
  State<SeeMoreCourses> createState() => _SeeMoreCoursesState();
}

class _SeeMoreCoursesState extends State<SeeMoreCourses> {
  HomepageProvider homeProvider = HomepageProvider();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<HomepageProvider>();
      final loginProvider = context.read<LoginProvider>();
      List<String> classList = loginProvider.classes?.map((c) => c.name).whereType<String>().toList() ?? [];
      classList.insert(0, 'All');
      if (!classList.contains(provider.selectedClass)) {
        provider.setSelectedClass('All');
      }
      provider.filteredclass(widget.catIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomepageProvider>(context, listen: true);
    
    // Build classList safely
    List<String> classList = context.read<LoginProvider>().classes?.map((c) => c.name).whereType<String>().toList() ?? [];
    classList.insert(0, 'All');
    
    // Ensure classList is not empty
    if (classList.isEmpty) {
      classList = ['All'];
    }
    
    // Ensure selectedClass is valid
    String currentSelectedClass = homeProvider.selectedClass;
    if (!classList.contains(currentSelectedClass)) {
      currentSelectedClass = 'All';
      // Update the provider with valid value
      WidgetsBinding.instance.addPostFrameCallback((_) {
        homeProvider.setSelectedClass('All');
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CustomBackButton(),
            ),
            SizedBox(width: 10),
            Text("All Courses"),
          ],
        ),
      ),  
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField<String>(
                  icon: Icon(Icons.keyboard_arrow_down_outlined,
                      color: AppColor.greyText),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  dropdownColor: AppColor.greyBackground,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: AppColor.greyStroke,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: AppColor.greyStroke,
                        width: 1.0,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.filter_alt_outlined,
                      color: AppColor.greyIcon,
                      size: 18,
                    ),
                  ),
                  hint: Text(
                    "Filter by Class",
                    style: TextStyle(
                        color: AppColor.greyText, fontWeight: FontWeight.w400),
                  ),
                  value: currentSelectedClass,
                  items: classList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Poppins')),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      homeProvider.setSelectedClass(newValue);
                      homeProvider.filteredclass(widget.catIndex);
                    }
                  },
                ),
              ),
              homeProvider.isFilterLoading
                  ? GridShimmeLoader()
                  : homeProvider.filteredClass.isEmpty 
                      ? Center(child: Text("No course in this category"))
                      : Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Wrap(
                              spacing: 12,
                              alignment: WrapAlignment.start,
                              children: [
                                ...List.generate(
                                  homeProvider.filteredClass.length,
                                  (index)  {
                                    final courseDetails = homeProvider.filteredClass[index].courseDetails;
                                    return GestureDetector(
                                    onTap:  () async {
                                      final isSubscribed = await homeProvider.iscourseSubscribed(context,courseDetails!.id ?? '');
                                      if (!context.mounted) return;
                                      final subcribedCourseProvider = context.read<SubcribedCourseProvider>();
                                      await subcribedCourseProvider.fetchCourseClasses(context: context, courseid:  courseDetails.id ?? '');
                                      final courseimage =subcribedCourseProvider.courseClasses!.data!.first.classImage;
                                      final coursetitle = subcribedCourseProvider.courseClasses!.data!.first.className;
                                      isSubscribed ? Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => SubscribedCourseClasses(courseId: courseDetails.id ?? '', image: courseimage!, title: coursetitle!)),
                                      )     
                                      : 
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) =>  CourseDetailsScreen(courseId: courseDetails.id ?? '',)),
                                      );
                                    },
                                    child: MyCourseCard(
                                    title: courseDetails?.name ?? "",
                                    imagePath: courseDetails?.image ?? "",
                                    rating: double.tryParse(
                                      homeProvider.filteredClass[index].avgStars.toString()
                                    ) ?? 0.0,
                                  )
                                );
                                }
                                )
                              ],
                            ),
                        ),
                      ),
            ],
          ),
        )
      ),
    );
  }
}