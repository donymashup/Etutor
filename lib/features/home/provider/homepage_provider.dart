import 'package:etutor/features/home/model/bannerimages_model.dart' as bannerModel;
import 'package:etutor/features/home/model/live_course_model.dart' as live_course_model;
import 'package:etutor/features/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomepageProvider extends ChangeNotifier {
  bool isLoading =false;
  List<live_course_model.Data> _liveCourse = [];
  List<bannerModel.Banner> _banner = [];

  List<live_course_model.Data> get livecourse => _liveCourse;
  List<bannerModel.Banner> get bannerurl => _banner;

  //get live courses 
  Future liveCourse (BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final response = await HomeService().getliveCourse(
      context: context);
      if (response != null ){
       _liveCourse = response.data!; 
      }else{
         _liveCourse = [];
        } 
      isLoading = false;
      notifyListeners();
  }
 
 //get bannerimages
  Future bannerimages (BuildContext context) async {
    isLoading = true;
    notifyListeners();
   try {
    final response = await HomeService().getBannerImages(
      context: context);
      if ( response != null && response.data != null ){
        _banner = response.data ?? []; 
      //  debugPrint(_banner.first.image);
        
      debugPrint('Banner list length: ${response.data!.length}');
      debugPrint('First banner image URL: ${(response.data ?? [bannerModel.Banner()])[0].image ?? ""}');
      debugPrint('First banner title: ${response.data!.first.title}');
      }else{
         _banner = [];
        } 
       }catch (e) {
          debugPrint('Error loading banner images: $e');
          _banner = [];
        }
      isLoading = false;
      notifyListeners();
  }
}