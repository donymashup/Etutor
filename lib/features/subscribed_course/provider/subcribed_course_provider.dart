import 'package:etutor/features/subscribed_course/model/course_chapter_model.dart' as coursechapterModel;
import 'package:flutter/material.dart';
import 'package:etutor/features/subscribed_course/model/course_classes_model.dart';
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';

class SubcribedCourseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int? _expandedIndex;
  
  CourseClassesModel? _courseClasses;
  List<coursechapterModel.Data?> _courseChapter = [];

  CourseClassesModel? get courseClasses => _courseClasses;
  List<coursechapterModel.Data?> get courseChapter => _courseChapter;
    int? get expandedIndex => _expandedIndex;

  // fetch class list
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

  // fetch chapter list
  Future fetchCourseChapter (BuildContext context,String packageSubjectId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await SubscribedCourseService().coursesChapter(
        context: context,
        packageSubjectId: packageSubjectId,
      );
      if (response != null && response.type == "success") {
        _courseChapter = response.data ?? [];
      } else {
        _courseClasses = null;
      }
    } catch (e) {
      debugPrint("Error fetching course chapter: $e");
      _courseClasses = null;
    }
    _isLoading = false;
    notifyListeners();
  }

   void toggleExpansion(int index) {
    _expandedIndex = _expandedIndex == index ? null : index;
    notifyListeners();
  }
}
