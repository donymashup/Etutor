import 'dart:convert';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/home/model/bannerimages_model.dart';
import 'package:etutor/features/home/model/live_course_model.dart';
import 'package:etutor/features/home/model/syllabus_based_livecourse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeService {
final storage = const FlutterSecureStorage();

  // fuction to fetch active courses
  Future<LiveCourseModel?> getliveCourse({
    required BuildContext context,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendGetRequestWithToken(
        url: '$baseUrl$getBannerImage',
        token: token        
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final liveCourseModel = LiveCourseModel.fromJson(jsonResponse);
           debugPrint(' live course status type :${liveCourseModel.type}');
          if (liveCourseModel.type == 'success') {
            return liveCourseModel;
          } else {
            showSnackbar(context, liveCourseModel.type!);
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch live courses: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }


// fuction to fetch banner images
  Future<BannerImageModel?> getBannerImages({
    required BuildContext context,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendGetRequestWithToken(
        url: '$baseUrl$getBannerImage',
        token: token
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final bannerImageModel = BannerImageModel.fromJson(jsonResponse);
          if (bannerImageModel.type == 'success') {
            return bannerImageModel;
          } else {
            showSnackbar(context, bannerImageModel.type!);
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch banner images: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  //fuction of fetch syllabus based livecourses
  Future<SyllabusLiveCourseModel?> getSyllabusLiveCourses({
    required BuildContext context,
    required String syllabusId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$syllabusLiveCourses',
        token: token,
        fields: {
          'syllabus' : syllabusId
        }
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final syllabusLiveCourseModel = SyllabusLiveCourseModel.fromJson(jsonResponse);
          if (syllabusLiveCourseModel.type == 'success') {
            return syllabusLiveCourseModel;
          } else {
            showSnackbar(context, syllabusLiveCourseModel.type!);
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch syllabus based Live course: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

}
