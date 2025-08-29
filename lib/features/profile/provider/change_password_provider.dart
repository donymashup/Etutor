import 'package:etutor/features/profile/model/change_password_model.dart';
import 'package:etutor/features/profile/service/change_password_service.dart';
import 'package:flutter/material.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool _isLoadingChangePassword = false;
  bool get isLoadingChangePassword => _isLoadingChangePassword;

  ChangePasswordModel? _changePassword;
  ChangePasswordModel? get changePassword => _changePassword;

  // Change password provider
  Future<void> fetchChangePassword({
    required BuildContext context,
    required String password,
  }) async {
    _isLoadingChangePassword = true;
    notifyListeners();

    try {
      final response = await ChangePasswordService().changePassword(
        context: context,
        password: password,
      );

      if (response != null && response.type == "success") {
        _changePassword = response;
      } else {
        _changePassword = null;
      }
    } catch (e) {
      debugPrint("Error fetching change password : $e");
      _changePassword = null;
    }

    _isLoadingChangePassword = false;
    notifyListeners();
  }
}
