import 'package:etutor/features/auth/models/login_model.dart';
import 'package:etutor/features/auth/models/register_model.dart';
import 'package:etutor/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoding = false;
  String _phone = "";
  String _code = "";
  int? _otp;
  bool? _isExist;
  List<LoginModel> _login = [];

  RegisterModel? _register;
 

  List<LoginModel> get isLogin => _login;
  String get phone => _phone;
  String get code => _code;
  bool? get isExist => _isExist;
  int? get otp => _otp;
  RegisterModel? get registerResponse => _register;

Future login (BuildContext context,String password) async {
    
    isLoding = true;
    notifyListeners();
    final response = await AuthService().login(
      context: context, 
      phone: _phone, 
      code: _code, 
      password: password);
    _login = response != null ? [response] : [];
    isLoding = false;
    notifyListeners();
  }

  Future checkMobileExist (BuildContext context,String phoneNumber,String code) async {
    isLoding = true;
    notifyListeners();
    final response = await AuthService().CheckMobileExist(
      context: context, 
      phone:phoneNumber, 
      code: code, );

    if (response == null)
    {_isExist = null;
    }else{
    _isExist = response.exists;
    _otp = response.otp;
    }
    debugPrint("otp$_otp");
    isLoding = false;
    notifyListeners();
  }

  void setPhoneNumber(String phone, String code) {
    _phone = phone;
    _code = code;
    notifyListeners(); 
  }


  // Future function to call register API
  Future register(BuildContext context, 
    String firstName, 
    String lastName,
    String email,
    String gender,
    String userClass,
    String syllabus,
    String school,
    String password,
    ) async {
    isLoding = true;
    notifyListeners();

    try {
      final response = await AuthService().register(
        context: context,
        phone: _phone,
        code: _code,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        userClass: userClass,
        syllabus: syllabus,
        school: school,
        password: password,
      );
      if (response != null) {
        _register = response;
        debugPrint("Registration successful: ${response.type}");
      } else {
        _register = null;
        debugPrint("Registration failed");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed, please try again.")),
        );
      } 
    }
      catch (e) {
        debugPrint("Error occurred during registration: $e");
        _register = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred, please try again.")),
        );
      }
      isLoding = false;
      notifyListeners();
    }
}


