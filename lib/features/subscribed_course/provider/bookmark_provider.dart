import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/drawer/Models/material_details_model.dart';
import 'package:etutor/features/drawer/Models/vedio_details_model.dart';
import 'package:etutor/features/drawer/service/content_details.dart';
import 'package:etutor/features/subscribed_course/model/book_mark_models.dart' as book_mark_models;
import 'package:etutor/features/subscribed_course/service/book_mark_services.dart';
import 'package:flutter/material.dart';

class BookmarkProvider extends ChangeNotifier {

bool isbookmarked  = false;
bool isLoading =false;
bool isCondentLoading = false;
List <book_mark_models.Data> bookmarkVedio =[];
List <book_mark_models.Data> bookmarkMaterial =[];
VedioDetailsModel _vDetails = VedioDetailsModel();
MaterialDetailsModel _mDetails = MaterialDetailsModel();

VedioDetailsModel get vedioDetails => _vDetails;
MaterialDetailsModel get materialDetails => _mDetails;


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
      isbookmarked == true 
      ?showSnackbar(context, "BookMark added")
      :showSnackbar(context, 'BookMark Removed');
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

  // fetch book marked contents
Future<void> getBookMarkedContents({
  required BuildContext context,
}) async {
  isLoading = true;
  notifyListeners();
  try {
    final response = await BookMarkServices().getBookMarked(
      context: context,
    );

    bookmarkMaterial = [];
    bookmarkVedio = [];

    if (response != null && response.data.isNotEmpty) {
      debugPrint("Bookmarks found: ${response.data.length}");

      for (var i = 0; i < response.data.length; i++) {
        final item = response.data[i];

        if (item.type == 'materials') {
          bookmarkMaterial.add(item);
        } else if (item.type == 'videos') {
          bookmarkVedio.add(item);
        }
      }
    } else {
      debugPrint("No bookmarked contents");
    }
  } catch (e) {
    debugPrint("Error fetching bookmarked content : $e");
    bookmarkMaterial = [];
    bookmarkVedio = [];
  }
  isLoading = false;
  notifyListeners();
}

// get vedio content details
 Future<void> getVDetails(
    BuildContext context,
    String contentid,
  ) async {
    isCondentLoading = true;
    notifyListeners();

    try {
      final response = await ContentDetails().getVedioDetails(
        context: context,
       contentId: contentid,
      );
      if (response != null) {
        _vDetails = response;
      } else {
        _vDetails = VedioDetailsModel();
      }
    } catch (e) {
     debugPrint("Error fetching vedio details: $e");
     isbookmarked;
    }
    isCondentLoading = true;
    notifyListeners();
  }

// get material content details
 Future<void> getMDetails(
    BuildContext context,
    String contentid,
  ) async {
    isCondentLoading = true;
    notifyListeners();

    try {
      final response = await ContentDetails().getMaterialDetails(
        context: context,
       contentId: contentid,
      );
      if (response != null) {
        _mDetails = response;
      } else {
        _mDetails = MaterialDetailsModel();
      }
    } catch (e) {
     debugPrint("Error fetching vedio details: $e");
     isbookmarked;
    }
    isCondentLoading = true;
    notifyListeners();
  }
}