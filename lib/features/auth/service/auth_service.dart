import 'dart:convert';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/auth/models/login_model.dart';
import 'package:flutter/material.dart';

class AuthService {
//future funxtion to call login api 
  Future<LoginModel?> login({
    required BuildContext context,
    required phone,
    required code,
    required password,
  }) async {
    try {
      debugPrint("enter");
      final response = await sendPostRequest(
        url: '$baseUrl$loginUrl',
        fields: {
          'phone':phone,
          'code':code,
          'password': password ,
        },
      );
       debugPrint("send");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final loginModel = LoginModel.fromJson(jsonResponse);
           debugPrint(loginModel.type );
          if (loginModel.type == 'success') {
            return loginModel;
          } else {
            showSnackbar(context, 'invalid credentials failed to login');
            return null;
          }
        }
      } else {
        debugPrint("Failed to login: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}
