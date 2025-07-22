import 'package:etutor/features/auth/models/login_model.dart';
import 'package:etutor/features/auth/service/auth_service.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoding = false;
  List<LoginModel> _login = [];
  List<LoginModel> get isLogin => _login;

Future login (BuildContext context,String phone,String code,String password) async {
    debugPrint("provider");
    isLoding = true;
    notifyListeners();
    var response = await AuthService().login(
      context: context, 
      phone: phone, 
      code: code, 
      password: password);
    _login = response != null ? [response] : [];
    isLoding = false;
    notifyListeners();
  }
}

