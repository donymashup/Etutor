import 'dart:convert';
import 'dart:io';
import 'package:etutor/features/profile/model/update_profile_model.dart';
import 'package:etutor/features/profile/model/upload_image_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/home/model/user_details_model.dart';
import 'package:http/http.dart' as http;

class UserDetailsService {
  final storage = const FlutterSecureStorage();

  /// Fetch user details
  Future<UserDetailsModel?> fetchUserDetails({
    required BuildContext context,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await http.get(
        Uri.parse("$baseUrl$getUserDetails"),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }
        final userDetailsModel = UserDetailsModel.fromJson(jsonResponse);
        if (userDetailsModel.type == 'success') {
          return userDetailsModel;
        } else {
          showSnackbar(context,
              "Failed to fetch user details: ${userDetailsModel.type}");
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("fetchUserDetails Error: $e");
      showSnackbar(context, "An error occurred while fetching user details");
      return null;
    }
  }

  /// Update user profile
  Future<UpdateProfileModel?> updateUserProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String userClass,
    required String syllabus,
    required String school,
    required String code,
    required String phone,
    required String gender,
    required String dob,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      final uploadedImageUrl = await storage.read(key: 'uploaded_image') ?? '';

      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final response = await http.post(
        Uri.parse('$baseUrl$updateProfile'),
        headers: {
          "Authorization": "Bearer $token",
        },
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'qualification': userClass,
          'syllabus': syllabus,
          'school': school,
          'country': code,
          'phone': phone,
          'gender': gender,
          'dob': dob,
          'address': "",
          'image': uploadedImageUrl,
        },
      );

      debugPrint("Update status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }
        return UpdateProfileModel.fromJson(jsonResponse);
      } else {
        showSnackbar(context, 'Fail to update the user details');
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error: $e");
      return null;
    }
  }

  /// Upload profile image
  Future<UploadImageModel?> uploadImage({
    required BuildContext context,
    required File file,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl$uploadImageUrl'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode == 200) {
        final jsonResponse = json.decode(responseBody);
        final imageModel = UploadImageModel.fromJson(jsonResponse);

        await storage.write(key: 'uploaded_image', value: imageModel.url);
        return imageModel;
      } else {
        showSnackbar(context, 'Failed to upload image: $responseBody');
        return null;
      }
    } catch (e) {
      print(e);
      showSnackbar(context, "Error: $e");
      return null;
    }
  }
}
