import 'dart:convert';
import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/auth/models/check_mobile_number_exist.dart';
import 'package:etutor/features/auth/models/drop_down_option_model.dart';
import 'package:etutor/features/auth/models/forgot_password_model.dart';
import 'package:etutor/features/auth/models/login_model.dart';
import 'package:etutor/features/auth/models/register_model.dart';
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
        showSnackbar(context, "Invalid cedential");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

// fuction to get all dropdownoption in registration
   Future<DropDownOptionModel?> dropDowmOption({
    required BuildContext context,
  }) async {
    try {
      final response = await sendGetRequest(url: '$baseUrl$dropDownOption');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final dropDownOptionModel = DropDownOptionModel.fromJson(jsonResponse);
           debugPrint(dropDownOptionModel.type );
          if (dropDownOptionModel.type == 'success') {
            return dropDownOptionModel;
          } else {
            showSnackbar(context, dropDownOptionModel.type!);
            return null;
          }
        }
      } else {
        debugPrint("Failed to fetch drop down options : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  //future function to call register api
  Future<RegisterModel?>register({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String userClass,
    required String syllabus,
    required String school,
    required String phone,
    required String code,
    required String password,
    required String dob,

    

  })async {
    try {
      final response = await sendPostRequest(
        url: '$baseUrl$registerUrl',
        fields: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'gender': gender,
          'qualification': userClass,
          'syllabus': syllabus,
          'school': school,
          'password': password,
          'country': code,
          'phone': phone,
          'dob': dob,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final registerModel = RegisterModel.fromJson(jsonResponse);
          debugPrint(registerModel.type);
          if (registerModel.type == 'success') {
            return registerModel;
          } else {
            showSnackbar(context, registerModel.message!);
            return null;
          }
        }
      } else {
        debugPrint("Failed to register: ${response.statusCode}");
        showSnackbar(context, "Failed to register");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

//future function for send OTP for Forgot Password
Future<ForgotPasswordModel?> sendOtpForgotPassord({
required BuildContext context,
required phone,
required code,
})async{
  try{
   final response = await sendPostRequest(
        url: '$baseUrl$forgotpassword',
        fields: {
          'phone':phone,
          'code':code,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final forgotPasswordModel = ForgotPasswordModel.fromJson(jsonResponse);       
            return forgotPasswordModel;
        }
      } else {
        debugPrint("Failed to send OTP For Forgot Password: ${response.statusCode}");
        return null;
      }
   }catch(e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}




