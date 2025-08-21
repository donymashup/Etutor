import 'package:etutor/features/subscribed_course/model/course_chapter_model.dart' as coursechapterModel;
import 'package:etutor/features/subscribed_course/model/rating_model.dart';
import 'package:etutor/features/subscribed_course/model/subjects_model.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/subscribed_course/model/course_classes_model.dart';
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';

class SubcribedCourseProvider extends ChangeNotifier {
  bool _isLoading = false;
  int? _expandedIndex ;
  bool _isLoadingsubjects = false;
  bool _isLoadingchapter = false; 
  bool _isLoadingrating =false;
  bool get isLoadingrating => _isLoadingrating;
  CourseClassesModel? _courseClasses;
  List<coursechapterModel.Data?> _courseChapter = [];

  int? get expandedIndex =>_expandedIndex;
  bool get isLoading => _isLoading;
  bool get isLoadingsubjects => _isLoadingsubjects;
  bool get isLoadingchapter => _isLoadingchapter;
  CourseClassesModel? get courseClasses => _courseClasses;
  List<coursechapterModel.Data?> get courseChapter => _courseChapter;

  

  // fetch class list
  SubjectsModel? _courseSubjects;
  SubjectsModel? get courseSubjects => _courseSubjects;

  //fecth rating
  RatingModel? _ratingCourses;
  RatingModel? get courseRating => _ratingCourses;

//classes provider
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
    _isLoadingchapter = true;
    notifyListeners();
    try {
      final response = await SubscribedCourseService().courseChapters(
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
      notifyListeners();
    }
    _isLoadingchapter = false;
    notifyListeners();
  }

   void toggleExpansion(int index) {
    _expandedIndex = _expandedIndex == index ? null : index;
    notifyListeners();
   }

//subjects provider
  Future<void> fetchClassSubjects({
    required BuildContext context,
    required String packageClassId,
  }) async {
    _isLoadingsubjects = true;
    notifyListeners();

    try {
      final response = await SubscribedCourseService().courseSubjects(
        context: context,
        packageClassId: packageClassId,
      );

      if (response != null && response.type == "success") {
        _courseSubjects = response;
      } else {
        _courseSubjects = null;
      }
    } catch (e) {
      debugPrint("Error fetching course classes : $e");
      _courseSubjects = null;
    }

    _isLoadingsubjects = false;
    notifyListeners();
  }


  Future<void> updateCourseRating({
    required BuildContext context,
    required String courseid,
    required String rating,
    required String comment
  }) async {
    _isLoadingrating = true;
    notifyListeners();

    try {
      final response = await SubscribedCourseService().courseRating(
        context: context,
        courseid: courseid,
        rating: rating,
        comment: comment,
      );

      if (response != null && response.type == "success") {
        _ratingCourses = response;
      } else {
        _ratingCourses = null;
      }
    } catch (e) {
      debugPrint("Error updating course rating  : $e");
      _ratingCourses = null;
    }

    _isLoadingrating = false;
    notifyListeners();
  }
}


