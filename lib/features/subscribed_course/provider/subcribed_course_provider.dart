import 'package:etutor/features/subscribed_course/model/batch_folder_content_model.dart';
import 'package:etutor/features/subscribed_course/model/course_chapter_model.dart'
    as coursechapterModel;
import 'package:etutor/features/subscribed_course/model/gettimeline_activity_model.dart';
import 'package:etutor/features/subscribed_course/model/insert_timeline_model.dart';
import 'package:etutor/features/subscribed_course/model/rating_model.dart';
import 'package:etutor/features/subscribed_course/model/subjects_model.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/subscribed_course/model/course_classes_model.dart';
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';

class SubcribedCourseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isClassLoading = false;
  int? _expandedIndex;
  bool _isLoadingsubjects = false;
  bool _isLoadingchapter = false;
  bool _isLoadingrating = false;

  bool get isLoadingrating => _isLoadingrating;
  bool _isLoadingInsertTLine = false;
  bool get isLoadingInsertTLine => _isLoadingInsertTLine;
  bool _isLoadingGetTLine = false;
  bool get isLoadingGetTLine => _isLoadingGetTLine;

  CourseClassesModel? _courseClasses;
  List<coursechapterModel.Data?> _courseChapter = [];

  int? get expandedIndex => _expandedIndex;
  bool get isLoading => _isLoading;
  bool get isClassLoading => _isClassLoading;
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

  //INsert TimeLInes
  InsertTimelineModel? _insertTLine;
  InsertTimelineModel? get insertTLine => _insertTLine;

  //Get Insert TimeLine
  GetTimelineActivityModel? _getTLine;
  GetTimelineActivityModel? get getTLine => _getTLine;

//GEt batchFolderContentModel
  bool _isLoadingBatchFolder = false;
  bool get isLoadingBatchFolder => _isLoadingBatchFolder;
  BatchFolderContentModel? _batchFolderContent;
  BatchFolderContentModel? get batchFolderContent => _batchFolderContent;

//classes provider
 Future<void> fetchCourseClasses({
  required BuildContext context,
  required String courseid,
}) async {
  _isClassLoading = true;
  notifyListeners();

  try {
    final response = await SubscribedCourseService().coursesClasses(
      context: context,
      courseid: courseid,
    );

    if (response != null && response.type == "success") {
      _courseClasses = response;
      debugPrint(" Course classes fetched: ${_courseClasses?.data?.length}");
    } else {
      _courseClasses = null;
      debugPrint("Course classes API returned null or error");
    }
  } catch (e) {
    debugPrint("Error fetching course classes: $e");
    _courseClasses = null;
  } finally {
    _isClassLoading = false;
    notifyListeners();
  }
}

  // fetch chapter list
  Future fetchCourseChapter(
      BuildContext context, String packageSubjectId) async {
    _isLoadingchapter = true;
    _expandedIndex = null;
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
    }finally{
    _isLoadingchapter = false;
    notifyListeners();
    }
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
     finally{
    _isLoadingsubjects = false;
    notifyListeners();
     }
  }

//update course rating provider
  Future<void> updateCourseRating(
      {required BuildContext context,
      required String courseid,
      required String rating,
      required String comment}) async {
    _isLoadingInsertTLine = true;
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

//insert timeline provider
  Future<void> insertTimelines(
      {required BuildContext context,
      required String contentid,
      required String type}) async {
    _isLoadingrating = true;
    notifyListeners();

    try {
      final response = await SubscribedCourseService().insertTimeline(
        context: context,
        contentid: contentid,
        type: type,
      );

      if (response != null && response.type == "success") {
        _insertTLine = response;
      } else {
        _insertTLine = null;
      }
    } catch (e) {
      debugPrint("Error inserting Timelines  : $e");
      _insertTLine = null;
    }

    _isLoadingInsertTLine = false;
    notifyListeners();
  }

  //insert GettimelineActivity provider
  Future<void> getTimeline(
      {required BuildContext context, required String date}) async {
    _isLoadingrating = true;
    notifyListeners();

    try {
      final response = await SubscribedCourseService().getTimelineActivity(
        context: context,
        date: date,
      );

      if (response != null && response.type == "success") {
        _getTLine = response;
      } else {
        _getTLine = null;
      }
    } catch (e) {
      debugPrint("Error inserting Timelines  : $e");
      _getTLine = null;
    }

    _isLoadingGetTLine = false;
    notifyListeners();
  }



//insert getBatchFolderContent provider
  Future<void> fetchBatchFolderContent({
    required BuildContext context,
    required String courseid,
    required String parentid,
  }) async {
    _isLoadingBatchFolder = true;
    notifyListeners();

    try {
      final response = await SubscribedCourseService().batchfoldercontent(
        context: context,
        courseid: courseid,
        parentid: parentid,
      );

      if (response != null && response.folders != null) {
        _batchFolderContent = response;
      } else {
        _batchFolderContent = null;
      }
    } catch (e) {
      debugPrint("Error fetching batch folder content: $e");
      _batchFolderContent = null;
    }

    _isLoadingBatchFolder = false;
    notifyListeners();
  }

 
 void setLoading (bool load){
  _isLoading = load;
  notifyListeners();
 }
}
