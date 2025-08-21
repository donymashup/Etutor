import 'package:etutor/features/my_course/model/course_details_model.dart' as course_details_model;
import 'package:etutor/features/my_course/service/course_details_service.dart';
import 'package:flutter/material.dart';

class CourseDetailsProvider extends  ChangeNotifier {
bool isLoading = false;
course_details_model.Package _package = course_details_model.Package();
List<course_details_model.ExploreChapters> _exploreChapter = [];
course_details_model.CourseDetails _courseDetails = course_details_model.CourseDetails();
List<course_details_model.Reviews> _reviews =[];

course_details_model.Package  get package => _package;
List<course_details_model.ExploreChapters> get exploreChapter =>_exploreChapter;
course_details_model.CourseDetails get courseDetails => _courseDetails;
List<course_details_model.Reviews> get reviews => _reviews;

Future getCourseDetails(String courseId , BuildContext context)async{
   isLoading = true;
    notifyListeners();
   try {
    final response = await CourseDetailsService().getDetails(
      context: context, 
      courseId: courseId);
      if ( response != null && response.data != null ){
        _package = response.data!.packageDetails!.package ?? course_details_model.Package();
        _exploreChapter = response.data!.exploreChapters ?? [];
        _courseDetails = response.data!.courseDetails ?? course_details_model.CourseDetails();
        _reviews = response.data!.reviews ?? [];
         notifyListeners();
      }else{
         _package = course_details_model.Package();
         _exploreChapter =[];
         _courseDetails = course_details_model.CourseDetails();
         _reviews =[];
        } 
       }catch (e) {
          debugPrint('Error fetching course details: $e');
           _package = course_details_model.Package();
           _exploreChapter =[];
           _courseDetails = course_details_model.CourseDetails();
           _reviews =[];
        }
      isLoading = false;
      notifyListeners();
}
}