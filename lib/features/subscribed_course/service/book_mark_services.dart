import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/subscribed_course/model/book_mark_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookMarkServices {
  final storage = const FlutterSecureStorage();

  // fuction make book mark
  Future<BookMark?> BookMarked({
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
        url: '$baseUrl$bookMark',
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
          final bookMarkModel = BookMark.fromJson(jsonResponse);
            return bookMarkModel;
        }
      } else {
        debugPrint(
            "Failed book mark : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }


    // fuction check is book marked
  Future<checkForBookMark?> isBookMarked({
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
        url: '$baseUrl$checkBookMark',
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
          final bookMarkModel = checkForBookMark.fromJson(jsonResponse);
            return bookMarkModel;
        }
      } else {
        debugPrint(
            "Failed to check book mark : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // fuction bookmarked contents
  Future<getUserBookmarkedContents?> getBookMarked({
    required BuildContext context,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendGetRequestWithToken(
        url: '$baseUrl$bookmarkedContent',
        token: token,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final bookMarkModel = getUserBookmarkedContents.fromJson(jsonResponse);
         if (bookMarkModel.type == 'success') {
            return bookMarkModel;
          } else {
            showSnackbar(context, (bookMarkModel.type ?? 'Unknown error').toString());
            return null;
          }
        }
      } else {
        debugPrint(
            "Failed to check book mark : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}