import 'package:etutor/features/auth/models/drop_down_option_model.dart';
import 'package:etutor/features/auth/models/login_model.dart';
import 'package:etutor/features/auth/models/register_model.dart';
import 'package:etutor/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoding = false;
  String _phone = "";
  String _code = "";
  String _countrysign = "";
  String? _token;
  int? _otp;
  bool? _isExist;
  List<LoginModel> _login = [];
  List<RegisterModel> _register = [];
  List<Syllabus> _syllabus = [];
  List<Classes> _class = [];
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  String? _classDropdown;
  String? _syllabusDropdown;

  String? get classDropdown => _classDropdown;
  String? get syllabusDropdown => _syllabusDropdown;
  List<LoginModel> get isLogin => _login;
  String get phone => _phone;
  String get code => _code;
  String get countrysign => _countrysign;
  String? get token => _token;
  bool? get isExist => _isExist;
  int? get otp => _otp;
  List<RegisterModel> get registerResponse => _register;
  List<Syllabus> get syllabus => _syllabus;
  List<Classes> get classes => _class;

  Future login(BuildContext context, String password) async {
    isLoding = true;
    notifyListeners();
    final response = await AuthService().login(
        context: context, phone: _phone, code: _code, password: password);
    if (response != null) {
      _login = [response];
      await _secureStorage.write(key: 'token', value: response.token);
      _token = await _secureStorage.read(key: 'token');
      debugPrint(_token);
    } else {
      _login = [];
      isLoding = false;
      notifyListeners();
    }
    isLoding = false;
    notifyListeners();
  }

  // reset the loding to false
  void resetLoading() {
    isLoding = false;
    notifyListeners();
  }

  Future checkMobileExist(
      BuildContext context, String phoneNumber, String code) async {
    isLoding = true;
    notifyListeners();
    final response = await AuthService().CheckMobileExist(
      context: context,
      phone: phoneNumber,
      code: code,
    );
    isLoding = false;
    notifyListeners();
    if (response == null) {
      _isExist = null;
    } else {
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

  // Future function to call register API
  Future register(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String gender,
    String userClass,
    String syllabus,
    String school,
    String password,
    String dob,
  ) async {
    isLoding = true;
    notifyListeners();

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
      dob: dob,
    );
    if (response != null) {
      _register = [response];
      debugPrint("Registration successful: ${response.type}");
    } else {
      _register = [];
      debugPrint("Registration failed");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed, please try again.")),
      );
    }
    isLoding = false;
    notifyListeners();
  }

// get dropdown values
  Future dropDownOptions(BuildContext context) async {
    final response = await AuthService().dropDowmOption(
      context: context,
    );
    if (response?.data == null) {
      _class = [];
      _syllabus = [];
    } else {
      _class = response!.data!.classes!;
      _syllabus = response.data!.syllabus!;
    }
    notifyListeners();
  }

//  update class drop down value
  void updateClassDropdown(String newValue) {
    _classDropdown = newValue;
    notifyListeners();
  }

  // update syllabus dropdown value
  void updateSyllabusDropdown(String newValue) {
    _syllabusDropdown = newValue;
    notifyListeners();
  }

// get class id by name
  String? getClassIdByName(String className) {
    try {
      return classes.firstWhere((c) => c.name == className).id;
    } catch (e) {
      return null;
    }
  }

// get syllabus id by name
  String? getSyllabusIdByName(String syllabusName) {
    try {
      return syllabus.firstWhere((s) => s.name == syllabusName).id;
    } catch (e) {
      return null;
    }
  }

// get class name by id
  String? getClassNameById(String classId) {
    try {
      return classes.firstWhere((c) => c.id == classId).name;
    } catch (e) {
      return null;
    }
  }

// Get syllabus name by ID
  String? getSyllabusNameById(String syllabusId) {
    try {
      return syllabus.firstWhere((s) => s.id == syllabusId).name;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'token');
    _classDropdown = null;
    _syllabusDropdown = null;
    _login = [];
    notifyListeners();
  }
}
