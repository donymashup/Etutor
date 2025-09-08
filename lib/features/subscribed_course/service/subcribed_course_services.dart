import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/subscribed_course/model/course_chapter_model.dart';
import 'package:etutor/features/subscribed_course/model/course_classes_model.dart';
import 'package:etutor/features/subscribed_course/model/gettimeline_activity_model.dart';
import 'package:etutor/features/subscribed_course/model/insert_timeline_model.dart';
import 'package:etutor/features/subscribed_course/model/material_model.dart';
import 'package:etutor/features/subscribed_course/model/practice_test_model.dart';
import 'package:etutor/features/subscribed_course/model/rating_model.dart';
import 'package:etutor/features/subscribed_course/model/subjects_model.dart';
import 'package:etutor/features/subscribed_course/model/videos_model.dart';
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

  // fuction to fetch videos
  Future<VideosModel?> chapterVideos({
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
        url: '$baseUrl$chapterVideoUrl',
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
          final videosModel = VideosModel.fromJson(jsonResponse);
          if (videosModel.type == 'success') {
            return videosModel;
          } else {
            showSnackbar(context, videosModel.type ?? 'Unknown error');
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch videos list: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // fetch chapter practice test
  Future<ChapterPraticeTestModel?> fetchPracticeTest({
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
        url: '$baseUrl$chapterPracticeTest',
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
          final chapterPraticeTestModel =
              ChapterPraticeTestModel.fromJson(jsonResponse);
          if (chapterPraticeTestModel.type == 'success') {
            return chapterPraticeTestModel;
          } else {
            showSnackbar(
                context, chapterPraticeTestModel.type ?? 'Unknown error');
            return null;
          }
        }
      } else {
        debugPrint(
            "Failed to fetch chapter practice test list: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // fuction to fetch Course Rating
  Future<RatingModel?> courseRating({
    required BuildContext context,
    required String courseid,
    required String rating,
    required String comment,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$updateCourseStars',
        token: token,
        fields: {
          'courseid': courseid,
          'comment' : comment,
          'rating' : rating,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final ratingModel = RatingModel.fromJson(jsonResponse);
          debugPrint(ratingModel.type);
          if (ratingModel.type == 'success') {
            return ratingModel;
          } else {
            showSnackbar(context, ratingModel.type ?? 'Unknown error');
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



  // fuction for insertTimeline
  Future<InsertTimelineModel?> insertTimeline({
    required BuildContext context,
    required String contentid,
    required String type,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$insertTline',
        token: token,
        fields: {
          'contentid': contentid,
          'type' : type,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final insertTimelineModel = InsertTimelineModel.fromJson(jsonResponse);
          if (insertTimelineModel.type == 'success') {
            return insertTimelineModel;
          } else {
            showSnackbar(context, insertTimelineModel.type ?? 'Unknown error');
            return null;
          }
        }
      } else {
        debugPrint("Failed to Inser TimeLine: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  
  // fuction for GETgetTimelineActivity
  Future<GetTimelineActivityModel?> getTimelineActivity({
    required BuildContext context,
    required String date,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$getTlineActivity',
        token: token,
        fields: {
          'date': date,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final getTimelineActivityModel = GetTimelineActivityModel.fromJson(jsonResponse);
          if (getTimelineActivityModel.type == 'success') {
            return getTimelineActivityModel;
          } else {
            showSnackbar(context, getTimelineActivityModel.type ?? 'Unknown error');
            return null;
          }
        }
      } else {
        debugPrint("Failed to GET Timeline Actvity: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

}
