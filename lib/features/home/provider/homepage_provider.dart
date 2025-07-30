import 'package:etutor/features/home/model/live_course_model.dart';
import 'package:etutor/features/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomepageProvider extends ChangeNotifier {
  bool isLoading =false;
  List<Data> _liveCourse = [];

   List<Data> get livecourse => _liveCourse;

  Future liveCourse (BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final response = await HomeService().getliveCourse(
      context: context);
      if (response != null ){
       _liveCourse = response.data!; 
      }else{
         _liveCourse = [];
        } 
      isLoading = false;
      notifyListeners();
  }
 
}