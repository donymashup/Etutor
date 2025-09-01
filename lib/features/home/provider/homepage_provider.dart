import 'package:etutor/features/home/model/bannerimages_model.dart'
    as banner_model;
import 'package:etutor/features/home/model/category_based_courses_model.dart' as category_based_courses_model;
import 'package:etutor/features/home/model/category_based_courses_model.dart%20';
import 'package:etutor/features/home/model/live_course_model.dart'
    as live_course_model;
import 'package:etutor/features/home/model/popular_course_model.dart'
    as popular_course_model;
import 'package:etutor/features/home/model/syllabus_based_livecourse.dart'
    as syllabus_live_corse;
import 'package:etutor/features/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomepageProvider extends ChangeNotifier {
  bool _mounted(BuildContext? context) {
    if (context == null) return true;
    return context.findRenderObject() != null;
  }

  bool isLoading = true;
  bool isSyllabuscourseLoading = true;
  bool isPopularLoading = true;
  bool isSubscribed = false;
  bool isCategoryHeader = true;


  List<String>_headerNames = [];
  List<category_based_courses_model.Data> _catogryDetails = [];
  int _selectedIndex = 0;
  List<banner_model.Banner> _banner = [];
  List<syllabus_live_corse.Data> _syllabusCourse = [];
  List<popular_course_model.Data> _popularCourse = [];
  int _currentCarouselPage = 0;

  List<banner_model.Banner> get bannerurl => _banner;
  List<syllabus_live_corse.Data> get syllabusCourse => _syllabusCourse;
  int get currentCarouselPage => _currentCarouselPage;
  List<popular_course_model.Data> get popularCourse => _popularCourse;
  List<category_based_courses_model.Data> get catogryDetails => _catogryDetails;
  List<String>get headerNames => _headerNames;
  int get selectedIndex => _selectedIndex;

  // //get live courses
  // Future liveCourse (BuildContext context) async {
  //   isLoading = true;
  //   notifyListeners();
  //   try{
  //   final response = await HomeService().getliveCourse(
  //     context: context);
  //     if (response != null ){
  //      _liveCourse = response.data!;
  //     }else{
  //        _liveCourse = [];
  //       }
  //       }catch (e) {
  //         debugPrint('Error loading banner images: $e');
  //         _banner = [];
  //       }
  //     isLoading = false;
  //     notifyListeners();
  // }

  //get bannerimages
  Future bannerimages(BuildContext context) async {
    isLoading = true;
    if (_mounted(context)) notifyListeners();
    try {
      final response = await HomeService().getBannerImages(context: context);
      if (response != null && response.data != null) {
        _banner = response.data ?? [];
        _currentCarouselPage = 0;
        if (_mounted(context)) notifyListeners();
      } else {
        _banner = [];
      }
    } catch (e) {
      debugPrint('Error loading banner images: $e');
      _banner = [];
    }
    isLoading = false;
    if (_mounted(context)) notifyListeners();
  }

  // current page index
  void setCurrentCarouselPage(int page) {
    _currentCarouselPage = page;
    notifyListeners();
  }

  // fetch syllabus based live courses
  Future syllabusBasedLiveCourses(
      BuildContext context, String syllabusId) async {
    isSyllabuscourseLoading = true;
    if (_mounted(context)) notifyListeners();
    try {
      final response = await HomeService()
          .getSyllabusLiveCourses(syllabusId: syllabusId, context: context);
      if (response != null && response.data != null) {
        _syllabusCourse = response.data ?? [];
        if (_mounted(context)) notifyListeners();
      } else {
        _syllabusCourse = [];
      }
    } catch (e) {
      debugPrint('Error fetching syllabus based live courses: $e');
      _syllabusCourse = [];
    }
    isSyllabuscourseLoading = false;
    if (_mounted(context)) notifyListeners();
  }

  // fetch popular courses
  Future popularCourses(
    BuildContext context,
  ) async {
    isPopularLoading = true;
    if (_mounted(context)) notifyListeners();
    try {
      final response = await HomeService().getPopularCourse(context: context);
      if (response != null && response.data != null) {
        _popularCourse = response.data!;
        if (_mounted(context)) notifyListeners();
      } else {
        _popularCourse = [];
      }
    } catch (e) {
      debugPrint('Error fetching popular courses: $e');
      _popularCourse = [];
    }
    isPopularLoading = false;
    if (_mounted(context)) notifyListeners();
  }

  // check if the course is subscribed or not
  Future<bool> iscourseSubscribed(BuildContext context, String courseId) async {
    try {
      final response = await HomeService().iscourseEnrolled(
        context: context,
        courseId: courseId,
      );

      if (response != null && response.data != null) {
        isSubscribed = response.data!;
        if (_mounted(context)) notifyListeners();
        return isSubscribed;
      } else {
        isSubscribed = false;
        return false;
      }
    } catch (e) {
      debugPrint('Error checking the subscription: $e');
      isSubscribed = false;
      return false;
    }
  }

  // fetch Category 0Header 
  Future categoryHeader(
    BuildContext context,
  ) async {
    isCategoryHeader = true;
    notifyListeners();
    try {
      final response = await HomeService().getCategoryHeaders(
        context: context,
      );
       if (response != null && response.data != null) {
        _catogryDetails = response.data!;
        
        notifyListeners();
      } else {
        isCategoryHeader = false;
        notifyListeners();
        return false;
      }
    isCategoryHeader = false;
    notifyListeners();
    } catch (e) {
      debugPrint('Error checking the subscription: $e');
      isCategoryHeader = false;
      notifyListeners();
      return false;
    }
    }

    void setSelectedIndex (int index){
      _selectedIndex = index;
      notifyListeners();
    }
    
  }


