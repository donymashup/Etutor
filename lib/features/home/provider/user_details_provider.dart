import 'package:flutter/material.dart';
import 'package:etutor/features/home/model/user_details_model.dart';
import 'package:etutor/features/home/service/user_details_service.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserDetailsModel _userDetails = UserDetailsModel();
  bool _isLoading = false;

  UserDetailsModel get userDetails => _userDetails;
  bool get isLoading => _isLoading;

  // Load user details from the service
  Future<UserDetailsModel?> loadUserDetails(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    debugPrint("Loading user details...");  
    try {
      final data = await UserDetailsService().fetchUserDetails(context: context);
      if (data != null && data.type == "success") {
        debugPrint("User details loaded successfully: ${data.data?.firstName}");
        _userDetails = data;
        _isLoading = false;
        notifyListeners();
        return data;
      } else {
        debugPrint("User details not loaded or invalid response.");
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
}
