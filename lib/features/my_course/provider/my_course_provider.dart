import 'package:etutor/features/my_course/model/my_course_model.dart'
    as my_course_model;
import 'package:etutor/features/my_course/service/my_course_service.dart';
import 'package:flutter/material.dart';

class MyCourseProvider extends ChangeNotifier {
  String _batchid = '';
  String get batchid => _batchid;
  bool isLoading = false;
  List<my_course_model.Data> _subscribedCorse = [];

  List<my_course_model.Data> get subscribedCourse => _subscribedCorse;

  void setLoadingTrue(){
    isLoading = true;
  }
  Future subscribedCourses(BuildContext context) async {
    if (mounted(context)) isLoading = true;
    if (mounted(context)) notifyListeners();
    try {
      final response =
          await MyCourseService().getSubscribedCourse(context: context);
      if (response != null && response.data != null) {
        _subscribedCorse = response.data ?? [];
        notifyListeners();
      } else {
        _subscribedCorse = [];
      }
    } catch (e) {
      debugPrint('Error loading banner images: $e');
      _subscribedCorse = [];
    }
    isLoading = false;
    notifyListeners();
  }

  void getbatchid(String batchid) {
    _batchid = batchid;
    notifyListeners();
  }
}

bool mounted(BuildContext context) {
  // Helper to check if context is still valid for notifyListeners
  return context.findRenderObject() != null;
}
