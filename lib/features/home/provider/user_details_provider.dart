import 'dart:io';

import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/profile/model/upload_image_model.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/home/model/user_details_model.dart';
import 'package:etutor/features/home/service/user_details_service.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserDetailsModel _userDetails = UserDetailsModel();
  bool _isLoading = false;
  bool _isUpdating = false;
  String? _syllabusId;

  UserDetailsModel get userDetails => _userDetails;
  bool get isLoading => _isLoading;
  bool get isUpdating => _isUpdating;
  String? get syllabusId => _syllabusId;

  // Load user details from the service
  Future<UserDetailsModel?> loadUserDetails(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final data =
          await UserDetailsService().fetchUserDetails(context: context);
      if (data != null && data.type == "success") {
        _userDetails = data;
        _syllabusId = _userDetails.data?.syllabus;
        notifyListeners();
        _isLoading = false;
        notifyListeners();
        return data;
      }
    } catch (e) {
      debugPrint("Error loading user details: $e");
    }

    _isLoading = false;
    notifyListeners();
    return null;
  }

  // Refresh method
  Future<void> refreshUserDetails(BuildContext context) async {
    await loadUserDetails(context);
  }

  // Clear data on logout
  void clearUserDetails() {
    _userDetails = UserDetailsModel();
    notifyListeners();
  }

  // Update profile method
  Future<void> updateUserProfile({
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
    _isUpdating = true;
    notifyListeners();

    try {
      final response = await UserDetailsService().updateUserProfile(
        context: context,
        firstName: firstName,
        lastName: lastName,
        email: email,
        userClass: userClass,
        syllabus: syllabus,
        school: school,
        code: code,
        phone: phone,
        gender: gender,
        dob: dob,
      );

      if (response != null && response.type == "success") {
        // Refresh user details after successful update
        await loadUserDetails(context);
      }

      _isUpdating = false;
      notifyListeners();
      // return response;
    } catch (e) {
      debugPrint("Error updating profile: $e");
      _isUpdating = false;
      notifyListeners();
    }
  }

  UploadImageModel? _uploadImageResponse;
  bool _isUploadingImage = false;

  UploadImageModel? get uploadImageResponse => _uploadImageResponse;
  bool get isUploadingImage => _isUploadingImage;
  Future<void> uploadUserProfileImage({
    required BuildContext context,
    required File file,
  }) async {
    _isUploadingImage = true;
    notifyListeners();

    try {
      final response = await UserDetailsService().uploadImage(
        context: context,
        file: file,
      );

      if (response != null && response.type == "Sucess") {
        _uploadImageResponse = response;

        if (response.type == "success") {
          await loadUserDetails(context); // Refresh after successful upload
        } else {
          showSnackbar(context, "Image upload failed: ${response.message}");
        }
      } else {
        debugPrint("No response from image upload service.");
      }
    } catch (e) {
      debugPrint("Error uploading image: $e");
    } finally {
      _isUploadingImage = false;
      notifyListeners();
    }
  }
}
