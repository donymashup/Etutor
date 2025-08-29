import 'dart:convert';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/profile/model/change_password_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChangePasswordService {
  final storage = const FlutterSecureStorage();

  // function to Change Password
  Future<ChangePasswordModel?> changePassword({
    required BuildContext context,
    required String password,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await sendPostRequestWithToken(
        url: '$baseUrl$changedPassword',
        token: token,
        fields: {
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse =
            json.decode(await response.stream.bytesToString());

        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final changePasswordModel =
              ChangePasswordModel.fromJson(jsonResponse);

          if (changePasswordModel.type == 'success') {
            showSnackbar(context, changePasswordModel.message);
            return changePasswordModel;
          } else {
            showSnackbar(context, changePasswordModel.message);
            return null;
          }
        }
      } else {
        debugPrint("Failed to change password: ${response.statusCode}");
        showSnackbar(context, "Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}
