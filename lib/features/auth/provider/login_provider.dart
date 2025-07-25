import 'package:etutor/features/auth/models/login_model.dart';
import 'package:etutor/features/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoding = false;
  String _phone = "";
  String _code = "";
  int? _otp;
  bool? _isExist;
  List<LoginModel> _login = [];
 

  List<LoginModel> get isLogin => _login;
  String get phone => _phone;
  String get code => _code;
  bool? get isExist => _isExist;
  int? get otp => _otp;

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
}

