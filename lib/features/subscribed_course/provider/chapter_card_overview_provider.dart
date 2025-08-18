import 'package:etutor/features/subscribed_course/model/material_model.dart' as material_model;
import 'package:etutor/features/subscribed_course/service/subcribed_course_services.dart';
import 'package:flutter/material.dart';

class ChapterCardOverviewProvider extends ChangeNotifier {
  bool isMaterialLoading = false;
  List <material_model.Data> _chapterMaterial = [];

  List <material_model.Data> get chapterMaterial =>_chapterMaterial;

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