import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/drawer/Models/material_details_model.dart';
import 'package:etutor/features/drawer/Models/vedio_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContentDetails {
  final storage = const FlutterSecureStorage();

  // fuction to fetch vedio details
  Future<VedioDetailsModel?> getVedioDetails({
    required BuildContext context,
    required String contentId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$vedioDetails',
        token: token, 
        fields: {
            'id' :contentId,
        }
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final vedioDetailsModel = VedioDetailsModel.fromJson(jsonResponse);
            return vedioDetailsModel;
        }
      } else {
        debugPrint("Failed to fetch vedio details: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // fuction to fetch material details
  Future<MaterialDetailsModel?> getMaterialDetails({
    required BuildContext context,
    required String contentId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$materialDetails',
        token: token, 
        fields: {
            'id' :contentId,
        }
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final materialDetailsModel = MaterialDetailsModel.fromJson(jsonResponse);
            return materialDetailsModel;
        }
      } else {
        debugPrint("Failed to fetch material details: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}