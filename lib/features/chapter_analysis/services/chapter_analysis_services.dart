import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/chapter_analysis/model/chapter_analysis_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChapterAnalysisServices {
  final storage = const FlutterSecureStorage();
  
  // fuction to studentChapterAnalysis videos
  Future<ChapterAnalysisModel?> chapterAnalysis({
    required BuildContext context,
    required String packageid,
    required String batchid,
    required String chapterid,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$studentChapterAnalysis',
        token: token,
        fields: {
          'packageid': packageid,
          'batchid': batchid,
          'chapterid' : chapterid,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final chapterAnalysisModel = ChapterAnalysisModel.fromJson(jsonResponse);
          if (chapterAnalysisModel.type == 'success') {
            return chapterAnalysisModel;
          } else {
            showSnackbar(context, chapterAnalysisModel.type ?? 'Unknown error');
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
}


