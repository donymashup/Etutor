
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

  Future<UserDetailsModel?> loadUserDetails(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await UserDetailsService().fetchUserDetails(context: context);
      if (data != null && data.type == "success") {
        _userDetails = data;
        _syllabusId = _userDetails.data?.syllabus;
      }
    } catch (e) {
      debugPrint("Error loading user details: $e");
    }
    _isLoading = false;
    notifyListeners();
    return _userDetails;
  }

  Future<void> refreshUserDetails(BuildContext context) async {
    await loadUserDetails(context);
  }

  void clearUserDetails() {
    _userDetails = UserDetailsModel();
    notifyListeners();
  }

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
        await loadUserDetails(context);
      }
    } catch (e) {
      debugPrint("Error updating profile: $e");
    }
    _isUpdating = false;
    notifyListeners();
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
      final response =
          await UserDetailsService().uploadImage(context: context, file: file);
      if (response != null && response.type == "success") {
        _uploadImageResponse = response;
        await loadUserDetails(context); // refresh instantly
      } else {
        showSnackbar(context, "Image upload failed: ${response?.message}");
      }
    } catch (e) {
      debugPrint("Error uploading image: $e");
    }
    _isUploadingImage = false;
    notifyListeners();
  }
}
