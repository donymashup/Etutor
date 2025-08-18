import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/subscribed_course/model/course_chapter_model.dart';
import 'package:etutor/features/subscribed_course/model/course_classes_model.dart';
import 'package:etutor/features/subscribed_course/model/material_model.dart';
import 'package:etutor/features/subscribed_course/model/subjects_model.dart';
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
            "Failed to fetch Courses Clasess based Subcribed Course: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

// fuction to fetch Subjects
  Future<SubjectsModel?> courseSubjects({
    required BuildContext context,
    required String packageClassId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$courseSubject',
        token: token,
        fields: {
          'packageClassId': packageClassId,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final subjectsModel = SubjectsModel.fromJson(jsonResponse);
          if (subjectsModel.type == 'success') {
            return subjectsModel;
          } else {
            showSnackbar(context, subjectsModel.type ?? 'Unknown error');
            return null;
          }
        }
      } else {
        debugPrint(
            "Failed to fetch Course Subjects based Subcribed Course Classes: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // fuction to fetch chapter
  Future<CourseChapterModel?> courseChapters({
    required BuildContext context,
    required String packageSubjectId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$courseChapter',
        token: token,
        fields: {
          'packageSubjectId': packageSubjectId,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final courseChapterModel = CourseChapterModel.fromJson(jsonResponse);
          if (courseChapterModel.type == 'success') {
            return courseChapterModel;
          } else {
            showSnackbar(context, courseChapterModel.type ?? 'Unknown error');
            return null;
          }
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

  // fetch chapter Materials
  Future<ChapterMaterialModel?> chapterMaterial({
    required BuildContext context,
    required String packageChapterId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$chapterMaterials',
        token: token,
        fields: {
          'packageChapterId': packageChapterId,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final chapterMaterialModel =
              ChapterMaterialModel.fromJson(jsonResponse);
          if (chapterMaterialModel.type == 'success') {
            return chapterMaterialModel;
          } else {
            showSnackbar(context, chapterMaterialModel.type ?? 'Unknown error');
            return null;
          }
        }
      } else {
        debugPrint(
            "Failed to fetch chapter material list: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}
