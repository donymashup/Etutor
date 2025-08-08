import 'package:etutor/features/home/model/bannerimages_model.dart' as banner_model;
import 'package:etutor/features/home/model/live_course_model.dart' as live_course_model;
import 'package:etutor/features/home/model/syllabus_based_livecourse.dart' as syllabus_live_corse;
import 'package:etutor/features/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomepageProvider extends ChangeNotifier {
  bool isLoading =false;
  List<live_course_model.Data> _liveCourse = [];
  List<banner_model.Banner> _banner = [];
  List<syllabus_live_corse.Data> _syllabusCourse = [];
  int _currentCarouselPage = 0;

  List<live_course_model.Data> get livecourse => _liveCourse;
  List<banner_model.Banner> get bannerurl => _banner;
  List<syllabus_live_corse.Data> get syllabusCourse => _syllabusCourse;
  int get currentCarouselPage => _currentCarouselPage;


  //get live courses 
  Future liveCourse (BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try{
    final response = await HomeService().getliveCourse(
      context: context);
      if (response != null ){
       _liveCourse = response.data!; 
      }else{
         _liveCourse = [];
        } 
        }catch (e) {
          debugPrint('Error loading banner images: $e');
          _banner = [];
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
         _currentCarouselPage = 0;
         notifyListeners();
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

  // current page index
  void setCurrentCarouselPage(int page) {
    _currentCarouselPage = page;
    notifyListeners();
  }
   
   // fetch syllabus based live courses
   Future syllabusBasedLiveCourses (BuildContext context) async {
    isLoading = true;
    notifyListeners();
   try { 
    final response = await HomeService().getSyllabusLiveCourses(
      syllabusId: '1',
      context: context);
      if ( response != null && response.data != null ){
        _syllabusCourse = response.data ?? [];
         notifyListeners();
      }else{
        _syllabusCourse  = [];
        } 
       }catch (e) {
          debugPrint('Error fetching syllabus based live courses: $e');
          _syllabusCourse = [];
        }
      isLoading = false;
      notifyListeners();
  }

}