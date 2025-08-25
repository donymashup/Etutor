import 'package:etutor/features/subscribed_course/model/practice_test_model.dart' as practice_test_model;
import 'package:etutor/features/subscribed_course/model/videos_model.dart';
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';
import 'package:etutor/features/subscribed_course/model/material_model.dart' as material_model;
import 'package:flutter/material.dart';

class ChapterCardOverviewProvider extends ChangeNotifier{

  bool _isLoadingVideos = false;
  bool isMaterialLoading = false;
  bool isTestLoading = false;
  List<practice_test_model.Data> _practiceTest =[];
  List <material_model.Data> _chapterMaterial = [];
  VideosModel? _chapterVideos;

  List<practice_test_model.Data> get practiceTest => _practiceTest;
  List <material_model.Data> get chapterMaterial =>_chapterMaterial;
  bool get isLoadingVideos => _isLoadingVideos;
  VideosModel? get chapterVideos => _chapterVideos;

    // fetch  chapter vedio list
    Future<void> fetchChapterVideos({
    required BuildContext context,
    required String packageChapterId,
  }) async {
    _isLoadingVideos = true;
    notifyListeners();

    try {
      final response = await SubscribedCourseService().chapterVideos(
        context: context,
        packageChapterId: packageChapterId,
      );

      if (response != null && response.type == "success") {
        _chapterVideos = response;
      } else {
        _chapterVideos = null;
      }
    } catch (e) {
      debugPrint("Error fetching course classes : $e");
      _chapterVideos = null;
    }
    _isLoadingVideos = false;
    notifyListeners();
  }

   // fetch chapter material list
  Future fetchChapterMaterial (BuildContext context,String packageChapterId) async {
    isMaterialLoading = true;
    notifyListeners();
    try {
      final response = await SubscribedCourseService().chapterMaterial(
        context: context, 
        packageChapterId: packageChapterId,  
      );
      if (response != null && response.type == "success") {
        _chapterMaterial = response.data ?? [];
      } else {
        _chapterMaterial = [];
      }
    } catch (e) {
      debugPrint("Error fetching course chapter: $e");
      _chapterMaterial = [];
    }
    isMaterialLoading = false;
    notifyListeners();
  }
  

  // fetch chapter practice  test list
  Future fetchPracticeTest (BuildContext context,String packageChapterId) async {
    isTestLoading = true;
    notifyListeners();
    try {
      final response = await SubscribedCourseService().fetchPracticeTest(
        context: context, 
        packageChapterId: packageChapterId,  
      );
      if (response != null && response.type == "success") {
        _practiceTest = response.data ?? [];
      } else {
        _practiceTest = [];
      }
    } catch (e) {
      debugPrint("Error fetching course chapter: $e");
      _practiceTest = [];
    }
    isTestLoading = false;
    notifyListeners();
  }
}