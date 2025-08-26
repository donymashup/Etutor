import 'package:etutor/features/subscribed_course/service/book_mark_services.dart';
import 'package:flutter/material.dart';

class BookmarkProvider extends ChangeNotifier {

bool isbookmarked  = false;
bool isLoading =false;

// make book mark
 Future<void> makeBookMark({
    required BuildContext context,
    required String contentid,
    required String type,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await BookMarkServices().BookMarked(
        context: context,
        contentid: contentid,
        type: type,
      );

      if (response != null && response.type != null) {
      isbookmarked = response.type!;
      } else {
        isbookmarked;
      }
    } catch (e) {
     debugPrint("Error book mark : $e");
     isbookmarked;
    }
    isLoading = false;
    notifyListeners();
  }

  // check book mark
 Future<void> checkBookMark({
    required BuildContext context,
    required String contentid,
    required String type,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await BookMarkServices().isBookMarked(
        context: context,
        contentid: contentid,
        type: type,
      );

      if (response != null && response.type != null) {
      isbookmarked = response.type!;
      } else {
        isbookmarked;
      }
    } catch (e) {
     debugPrint("Error checking book mark : $e");
     isbookmarked;
    }
    isLoading = false;
    notifyListeners();
  }

}