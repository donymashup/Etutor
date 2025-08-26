import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/test_series/model/attended_tests_model.dart';
import 'package:etutor/features/test_series/model/ongoing_tests_model.dart';
import 'package:etutor/features/test_series/model/test_performance_model.dart';
import 'package:etutor/features/test_series/model/upcoming_tests_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TestService {
  final storage = const FlutterSecureStorage();

  Future<AttendedTestsModel?> getAttendedTests(
      {required BuildContext context}) async {
    try {
      final token = await storage.read(key: 'token');

      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await sendGetRequestWithToken(
          url: '$baseUrl$attendedTestsUrl', token: token);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final attendedTestsModel = AttendedTestsModel.fromJson(jsonResponse);
          if (attendedTestsModel.type == 'success') {
            return attendedTestsModel;
          } else {
            showSnackbar(context, attendedTestsModel.type ?? "");
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch attended tests: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  Future<OngoingTestsModel?> getOngoingTests(
      {required BuildContext context}) async {
    try {
      final token = await storage.read(key: 'token');

      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await sendGetRequestWithToken(
          url: '$baseUrl$ongoingTestsUrl', token: token);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final ongoingTestsModel = OngoingTestsModel.fromJson(jsonResponse);
          if (ongoingTestsModel.type == 'success') {
            return ongoingTestsModel;
          } else {
            showSnackbar(context, ongoingTestsModel.type ?? "");
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch ongoing tests: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  Future<UpcomingTestsModel?> getUpcomingTests(
      {required BuildContext context}) async {
    try {
      final token = await storage.read(key: 'token');

      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await sendGetRequestWithToken(
          url: "$baseUrl$upcomingTestsUrl", token: token);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, "Invalid Response from server");
          return null;
        } else {
          final upcomingTestsModel = UpcomingTestsModel.fromJson(jsonResponse);
          if (upcomingTestsModel.type == "success") {
            return upcomingTestsModel;
          } else {
            showSnackbar(
                context, upcomingTestsModel.message ?? "Something went wrong");
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch ongoing tests: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }


  // fuction to fetch Test Performance
  Future<ExamPerformanceModel?> testReport({
    required BuildContext context,
    required String type,
    required String testid,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$examPerformance',
        token: token,
        fields: {
          'type': type,
          'testid' : testid,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final examPerformanceModel = ExamPerformanceModel.fromJson(jsonResponse);

            return examPerformanceModel;

        }
      } else {
        debugPrint("Failed to fetch chapter list: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}
