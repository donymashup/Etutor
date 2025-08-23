import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/live/model/live_class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LiveClassService {
  final storage = const FlutterSecureStorage();

  Future<LiveClassModal?> getLiveClasses(BuildContext context) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Invalid Token");
        return null;
      }

      final response = await sendGetRequestWithToken(
          url: '$baseUrl$liveClassesUrl', token: token);
      if (response.statusCode == 200) {
        final responseJson = json.decode(await response.stream.bytesToString());
        if (responseJson == null || responseJson.isEmpty) {
          showSnackbar(context, "Invalid Json format");
          return null;
        } else {
          final liveClassModel = LiveClassModal.fromJson(responseJson);
          if (liveClassModel.type == "success") {
            return liveClassModel;
          } else {
            showSnackbar(context, liveClassModel.message ?? "");
          }
        }
      } else {
        debugPrint("Something went wrong! Invalid Status Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}
