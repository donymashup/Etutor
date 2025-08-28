import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/subscribed_course/model/book_mark_models.dart' as book_mark_models;
import 'package:etutor/features/subscribed_course/service/book_mark_services.dart';
import 'package:flutter/material.dart';

class BookmarkProvider extends ChangeNotifier {

bool isbookmarked  = false;
bool isLoading =false;
List <book_mark_models.Data> bookmarkVedio =[];
List <book_mark_models.Data> bookmarkMaterial =[];

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
      if (response != null && response.data.isEmpty) {

       for (var i = 0; i < response.data.length; i++){
         if(response.data[i].type == 'materials'){
           bookmarkMaterial.add(response.data[i]);
         }else if(response.data[i].type == 'vedios'){

         }
       }
      } else {
        bookmarkMaterial =[];
        bookmarkVedio =[];
      }
    } catch (e) {
     debugPrint("Error fetching book marked content : $e");
     bookmarkMaterial =[];
        bookmarkVedio =[];
    }
    isLoading = false;
    notifyListeners();
  }
  
}