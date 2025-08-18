import 'package:etutor/features/subscribed_course/model/videos_model.dart';
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';
import 'package:etutor/features/subscribed_course/model/material_model.dart' as material_model;
import 'package:flutter/material.dart';

class ChapterCardOverviewProvider extends ChangeNotifier{

  bool _isLoadingVideos = false;
  bool isMaterialLoading = false;
  List <material_model.Data> _chapterMaterial = [];
  VideosModel? _chapterVideos;

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

   // fetch chapter list
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
  
}