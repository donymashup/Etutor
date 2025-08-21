import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/my_course/model/course_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CourseDetailsService {
  final storage = const FlutterSecureStorage();
  
  // fuction to fetch subscribed courses
  Future<CourseDetailsModal?> getDetails({
    required BuildContext context,
    required  String courseId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$courseDetails',
        token: token,
        fields: {
          'courseid' : courseId,
        }  
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final courseDetailsModal = CourseDetailsModal.fromJson(jsonResponse);
          if (courseDetailsModal.type == 'success') {
            return courseDetailsModal;
          } else {
            showSnackbar(context, courseDetailsModal.type!);
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch course details : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

}