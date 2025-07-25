import 'package:etutor/features/auth/models/drop_down_option_model.dart';
import 'package:etutor/features/auth/models/login_model.dart';
import 'package:etutor/features/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_field/countries.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoding = false;
  String _phone = "";
  String _code = "";
   String _countrysign = "";
  int? _otp;
  bool? _isExist;
  List<LoginModel> _login = [];
  List<Syllabus> _syllabus =[];
  List<Classes> _class = [];
 
  List<LoginModel> get isLogin => _login;
  String get phone => _phone;
  String get code => _code;
  String get countrysign => _countrysign;
  bool? get isExist => _isExist;
  int? get otp => _otp;
  List<Syllabus> get syllabus => _syllabus;
  List<Classes> get classes => _class;

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

  void setPhoneNumber(String phone, String code, String countrysign) {
    _phone = phone;
    _code = code;
    _countrysign = countrysign;
    notifyListeners(); 
  }

  Future dropDownOptions(BuildContext context) async {
    final response = await AuthService().dropDowmOption(
      context: context, );
    if (response?.data == null){
        _class =[];
        _syllabus = [];
    }else{
      _class = response!.data!.classes!;
      _syllabus = response.data!.syllabus!;
    } 
  }


}

