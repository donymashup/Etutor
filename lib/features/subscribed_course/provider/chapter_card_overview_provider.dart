import 'package:etutor/features/subscribed_course/model/videos_model.dart';
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';
import 'package:flutter/material.dart';

class ChapterCardOverviewProvider extends ChangeNotifier{

  bool _isLoadingVideos = false;
  bool get isLoadingVideos => _isLoadingVideos;
  VideosModel? _chapterVideos;
  VideosModel? get chapterVideos => _chapterVideos;


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

  
  
}