import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/my_course/model/my_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyCourseService {
  final storage = const FlutterSecureStorage();
  
  // fuction to subscribed courses
  Future<MyCourseModel?> getPopularCourse({
    required BuildContext context,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendGetRequestWithToken(
        url: '$baseUrl$getSubscribedCourse',
        token: token        
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final myCourseModel = MyCourseModel.fromJson(jsonResponse);
          if (myCourseModel.type == 'success') {
            return myCourseModel;
          } else {
            showSnackbar(context, myCourseModel.type!);
            return null;
          }
        }
      } else {
        debugPrint("Failed to subscribed courses: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

}