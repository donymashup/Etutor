import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/subscribed_course/model/course_classes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SubscribedCourseService {
  final storage = const FlutterSecureStorage();

  // fuction to fetch Subscribed Course Classes
  Future<CourseClassesModel?> coursesClasses({
    required BuildContext context,
    required String courseid,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$courseClasses',
        token: token,
        fields: {
          'courseid': courseid,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final courseClassesModel = CourseClassesModel.fromJson(jsonResponse);
          if (courseClassesModel.type == 'success') {
            return courseClassesModel;
          } else {
            showSnackbar(context, courseClassesModel.type ?? 'Unknown error');
            return null;
          }
        }
      } else {
        debugPrint(
            "Failed to fetch syllabus based Live course: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}
