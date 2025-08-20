import 'package:etutor/features/chapter_analysis/model/chapter_analysis_model.dart';
import 'package:etutor/features/chapter_analysis/services/chapter_analysis_services.dart';
import 'package:flutter/material.dart';

class ChapterAnalysisProvider extends ChangeNotifier{

  bool _isLoadingChapterAnalysis = false;
  ChapterAnalysisModel? _chapterAnalysis;

  bool get isLoadingChapterAnalysis => _isLoadingChapterAnalysis;
  ChapterAnalysisModel? get chapterAnalysis => _chapterAnalysis;

  
// fetch  chapter vedio list
    Future<void> fetchChapterAnalysis({
    required BuildContext context,
    required String packageid,
    required String batchid,
    required String chapterid,
  }) async {
    _isLoadingChapterAnalysis = true;
    notifyListeners();

    try {
      final response = await ChapterAnalysisServices().chapterAnalysis(
        context: context,
        packageid: packageid,
        batchid: batchid,
        chapterid:chapterid,
      );

      if (response != null && response.type == "success") {
        _chapterAnalysis = response;
      } else {
        _chapterAnalysis = null;
      }
    } catch (e) {
      debugPrint("Error fetching course classes : $e");
      _chapterAnalysis = null;
    }

    _isLoadingChapterAnalysis = false;
    notifyListeners();
  }

} 