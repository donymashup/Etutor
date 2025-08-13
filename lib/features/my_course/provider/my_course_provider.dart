import 'package:etutor/features/my_course/model/my_course_model.dart' as my_course_model;
import 'package:etutor/features/my_course/service/my_course_service.dart';
import 'package:flutter/material.dart';

class MyCourseProvider extends ChangeNotifier{
  bool isLoading = false;
  List<my_course_model.Data>_subscribedCorse =[];
  
   List<my_course_model.Data> get subscribedCourse => _subscribedCorse;

   Future subscribedCourses (BuildContext context) async {
    isLoading = true;
    notifyListeners();
   try {
    final response = await MyCourseService().getSubscribedCourse(
      context: context);
      if ( response != null && response.data != null ){
        _subscribedCorse = response.data ?? [];
         notifyListeners();
      }else{
         _subscribedCorse = [];
        } 
       }catch (e) {
          debugPrint('Error loading banner images: $e');
          _subscribedCorse = [];
        }
      isLoading = false;
      notifyListeners();
  }
}
