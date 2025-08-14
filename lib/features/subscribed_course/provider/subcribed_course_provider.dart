import 'package:flutter/material.dart';
import 'package:etutor/features/subscribed_course/model/course_classes_model.dart';
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';

class SubcribedCourseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CourseClassesModel? _courseClasses;
  CourseClassesModel? get courseClasses => _courseClasses;

  Future<void> fetchCourseClasses({
    required BuildContext context,
    required String courseid,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await SubscribedCourseService().coursesClasses(
        context: context,
        courseid: courseid,
      );

      if (response != null && response.type == "success") {
        _courseClasses = response;
      } else {
        _courseClasses = null;
      }
    } catch (e) {
      debugPrint("Error fetching course classes : $e");
      _courseClasses = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
