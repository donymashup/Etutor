import 'dart:convert';
import 'package:etutor/features/profile/model/update_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/home/model/user_details_model.dart';

class UserDetailsService {
  final storage = const FlutterSecureStorage();

  Future<UserDetailsModel?> fetchUserDetails(
      {required BuildContext context}) async {
    try {
      final token = await storage.read(key: 'token');
      debugPrint("Token: $token");

      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await sendGetRequestWithToken(
        url: "$baseUrl$getUserDetails",
        token: token,
      );
      final jsonResponse = json.decode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final userDetailsModel = UserDetailsModel.fromJson(jsonResponse);
          debugPrint(userDetailsModel.type);
          if (userDetailsModel.type == 'success') {
            return userDetailsModel;
          } else {
            showSnackbar(context,
                "Failed to fetch user details: ${userDetailsModel.type}");
            return null;
          }
        }
      } else {
        debugPrint("Failed fetch user details: ${response.statusCode}");
        await storage.write(key: 'isLogin', value: 'false');
        return null;
      }
    } catch (e) {
      debugPrint("fetchUserDetails Error: $e");
      showSnackbar(context, "An error occurred while fetching user details");
      return null;
    }
  }

  Future<UpdateProfile?> updateUserProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String userClass,
    required String syllabus,
    required String school,
  }) async {
    try {
      final token = await storage.read(key: 'token');

      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await sendPostRequestWithToken(
        url: '$baseUrl$updateProfile',
        token: token, 
        fields: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'qualification': userClass,
          'syllabus': syllabus,
          'school': school,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final updateProfile = UpdateProfile.fromJson(jsonResponse);
          debugPrint(updateProfile.type);
          return updateProfile;
        }
      } else {
        debugPrint("Failed to update profile: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error: $e");
      return null;
    }
  }
}
