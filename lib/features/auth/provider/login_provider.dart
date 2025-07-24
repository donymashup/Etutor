import 'package:etutor/features/auth/models/check_mobile_number_exist.dart';
import 'package:etutor/features/auth/models/login_model.dart';
import 'package:etutor/features/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoding = false;
  String _phone = "";
  String _code = "";
  bool? _isExist;
  List<LoginModel> _login = [];
  List<CheckMobileExistModel> _check =[];

  List<LoginModel> get isLogin => _login;
  String get phone => _phone;
  String get code => _code;

Future login (BuildContext context,String password) async {
    
    isLoding = true;
    notifyListeners();
    var response = await AuthService().login(
      context: context, 
      phone: _phone, 
      code: _code, 
      password: password);
    _login = response != null ? [response] : [];
    isLoding = false;
    notifyListeners();
  }

  Future checkMobileExist (BuildContext context) async {
    isLoding = true;
    notifyListeners();
    var response = await AuthService().CheckMobileExist(
      context: context, 
      phone: _phone, 
      code: _code, );
      _check = response != null ? [response] : [];
       _isExist = _check.first.exists;
    isLoding = false;
    notifyListeners();
  }

  void setPhoneNumber(String phone, String code) {
    _phone = phone;
    _code = code;
    debugPrint(_phone);
    notifyListeners(); 
  }
}

