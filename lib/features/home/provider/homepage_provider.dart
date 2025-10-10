import 'package:etutor/features/home/model/bannerimages_model.dart'
    as banner_model;
import 'package:etutor/features/home/model/category_based_courses_model.dart'
    as category_based_courses_model;
import 'package:etutor/features/home/model/popular_course_model.dart'
    as popular_course_model;
import 'package:etutor/features/home/service/home_service.dart';
import 'package:flutter/material.dart';

class HomepageProvider extends ChangeNotifier {
  bool _mounted(BuildContext? context) {
    if (context == null) return true;
    return context.findRenderObject() != null;
  }

  bool isLoading = false;
  bool isFilterLoading = false;
  bool isPopularLoading = false;
  bool isSubscribed = false;
  bool isCategoryHeader = false;

  int _selectedIndex = 0;
  int _currentCarouselPage = 0;
  List<banner_model.Banner> _banner = [];
  List<popular_course_model.Data> _popularCourse = [];
  List<category_based_courses_model.Data> _catogryDetails = [];
  List<category_based_courses_model.Courses> _filteredClass = [];
  String _selectedClass = 'All';

  List<banner_model.Banner> get bannerurl => _banner;
  List<popular_course_model.Data> get popularCourse => _popularCourse;
  List<category_based_courses_model.Data> get catogryDetails => _catogryDetails;
  List<category_based_courses_model.Courses> get filteredClass => _filteredClass;
  int get selectedIndex => _selectedIndex;
  int get currentCarouselPage => _currentCarouselPage;
  String get selectedClass => _selectedClass;

  //make the loading bool true
  void makeLoadingTrue() {
    isPopularLoading = true;
    isCategoryHeader = true;
    notifyListeners();
  }

  void setSelectedClass(String cls) {
    if (cls.isNotEmpty) {
      _selectedClass = cls;
      notifyListeners();
    }
  }

  String convertClassFormat(String input) {
    if (input.isEmpty) return input;
    if (input == "Mental Ability Class") return "mental ability";

    // Convert to lowercase
    String result = input.toLowerCase();
    RegExp regExp = RegExp(r'class\s+(\d+)');
    Match? match = regExp.firstMatch(result);

    if (match != null) {
      String numberStr = match.group(1)!;
      int number = int.parse(numberStr);
      String formattedNumber = number.toString().padLeft(2, '0');
      return 'class $formattedNumber';
    }
    return result;
  }

  void filteredclass(int catIndex) {
    isFilterLoading = true;
    notifyListeners();

    try {
      if (catIndex < 0 || catIndex >= catogryDetails.length) {
        _filteredClass = [];
        isFilterLoading = false;
        notifyListeners();
        return;
      }

      if (catogryDetails[catIndex].courses != null) {
        if (_selectedClass.toLowerCase() == "all") {
          _filteredClass = catogryDetails[catIndex].courses ?? [];
        } else {
          _filteredClass = catogryDetails[catIndex].courses!.where((course) {
            return course.courseDetails?.name
                    ?.toLowerCase()
                    .contains(convertClassFormat(_selectedClass)) ??
                false;
          }).toList();
        }
      } else {
        _filteredClass = [];
      }
    } catch (e) {
      debugPrint('Error filtering classes: $e');
      _filteredClass = [];
    }

    isFilterLoading = false;
    notifyListeners();
  }

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

  // fetch popular courses
  Future popularCourses(
    BuildContext context,
  ) async {
    isPopularLoading = true;
   // if (_mounted(context)) 
    notifyListeners();
    try {
      final response = await HomeService().getPopularCourse(context: context);
      debugPrint("popular course type ${response?.type}");
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
   // if (_mounted(context))
     notifyListeners();
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
      debugPrint("catogory heder type : ${response?.type}");
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

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
