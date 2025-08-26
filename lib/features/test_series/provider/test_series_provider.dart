import 'package:etutor/features/test_series/model/attended_tests_model.dart'
    as attended_test_model;
import 'package:etutor/features/test_series/model/ongoing_tests_model.dart'
    as ongoing_test_model;
import 'package:etutor/features/test_series/model/test_performance_model.dart';
import 'package:etutor/features/test_series/model/upcoming_tests_model.dart'
    as upcoming_test_model;
import 'package:etutor/features/test_series/service/tests_service.dart';
import 'package:flutter/material.dart';

class TestSeriesProvider extends ChangeNotifier {
  bool isAttendedTestsLoading = false;
  bool isUpcomingTestsLoading = false;
  bool isOngoingTestsLoading = false;
   bool _isLoadingtestreport = false;
   bool get isLoadingtestreport => _isLoadingtestreport;
    
   
   ExamPerformanceModel? _testReports;
   ExamPerformanceModel? get testReports  => _testReports;

  List<attended_test_model.Data> _attendedTests = [];
  List<attended_test_model.Data> get attendedTests => _attendedTests;

  List<ongoing_test_model.Data> _ongoingTests = [];
  List<ongoing_test_model.Data> get ongoingTests => _ongoingTests;

  List<upcoming_test_model.Data> _upcomingTests = [];
  List<upcoming_test_model.Data> get upcomingTests => _upcomingTests;

  Future<void> fetchAttendedTests(BuildContext context) async {
    isAttendedTestsLoading = true;
    notifyListeners();

    try {
      final response = await TestService().getAttendedTests(context: context);
      if (response != null && response.data != null) {
        _attendedTests = response.data ?? [];
        notifyListeners();
      } else {
        _attendedTests = [];
      }
    } catch (e) {
      debugPrint('Error loading attended tests: $e');
      _attendedTests = [];
    }

    isAttendedTestsLoading = false;
    notifyListeners();
  }

  Future<void> fetchOngoingTests(BuildContext context) async {
    isOngoingTestsLoading = true;
    notifyListeners();

    try {
      final response = await TestService().getOngoingTests(context: context);
      if (response != null && response.data != null) {
        _ongoingTests = response.data ?? [];
        notifyListeners();
      } else {
        _ongoingTests = [];
      }
    } catch (e) {
      debugPrint('Error loading ongoing tests: $e');
      _ongoingTests = [];
    }

    isOngoingTestsLoading = false;
    notifyListeners();
  }

  Future<void> fetchUpcomingTests(BuildContext context) async {
    isUpcomingTestsLoading = true;
    notifyListeners();

    try {
      final response = await TestService().getUpcomingTests(context: context);
      if (response != null && response.data != null) {
        _upcomingTests = response.data ?? [];
        notifyListeners();
      } else {
        _upcomingTests = [];
      }
    } catch (e) {
      debugPrint('Error loading upcoming tests: $e');
      _upcomingTests = [];
    }

    isUpcomingTestsLoading = false;
    notifyListeners();
  }


  //Test performace reportprovider
  Future<void> fetchTestReports({
    required BuildContext context,
    required String type,
    required String testid
  }) async {
    _isLoadingtestreport = true;
    notifyListeners();

    try {
      final response = await TestService().testReport(
        context: context,
        type: type,
        testid:testid,
      );

      if (response != null) {
        _testReports = response;
      } else {
        _testReports = null;
      }
    } catch (e) {
      debugPrint("Error fetching test report: $e");
      _testReports = null;
    }

    _isLoadingtestreport = false;
    notifyListeners();
  }
}
