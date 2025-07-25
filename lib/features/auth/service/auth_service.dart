import 'dart:convert';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/auth/models/check_mobile_number_exist.dart';
import 'package:etutor/features/auth/models/login_model.dart';
import 'package:flutter/material.dart';

class AuthService {
//future function to check wheather phone nmber exist or not
Future<CheckMobileExistModel?> CheckMobileExist({
required BuildContext context,
required phone,
required code,
})async{
  try{
   final response = await sendPostRequest(
        url: '$baseUrl$checkMobileNumberExixt',
        fields: {
          'phone':phone,
          'country':code,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final checkMobileExistModel = CheckMobileExistModel.fromJson(jsonResponse);
           debugPrint(checkMobileExistModel.type );         
            return checkMobileExistModel;
        }
      } else {
        debugPrint("Failed to check mobile number: ${response.statusCode}");
        return null;
      }
   }catch(e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }


//future function to call login api 
  Future<LoginModel?> login({
    required BuildContext context,
    required phone,
    required code,
    required password,
  }) async {
    try {
      final response = await sendPostRequest(
        url: '$baseUrl$loginUrl',
        fields: {
          'country':code,
          'phone': phone,      
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final checkMobileExistModel = LoginModel.fromJson(jsonResponse);
           debugPrint(checkMobileExistModel.type );
          if (checkMobileExistModel.type == 'success') {
            return checkMobileExistModel;
          } else {
            showSnackbar(context, checkMobileExistModel.message!);
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
