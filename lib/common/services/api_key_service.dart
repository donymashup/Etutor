import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/common/models/razor_pay_key_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiKeyService {
final storage = const FlutterSecureStorage();
   Future<RazorPayKeyModel?> razorApiKey() async {
    try {
       final token = await storage.read(key: 'token');
      if (token == null) {
        debugPrint("Token not found. Please log in again.");
        return null;
      }
      final response = await sendGetRequestWithToken(
        url: '$baseUrl$razorKey', 
        token: token,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          debugPrint('Invalid response from server');
          return null;
        } else {
          final razorPayKeyModel =
              RazorPayKeyModel.fromJson(jsonResponse);
          return razorPayKeyModel;
        }
      } else {
        debugPrint("Failed to fetch razorpay key: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error : $e");
      return null;
    }
  }
}