import 'dart:convert';

class UserDetailsModel {
  String? type;
  Data? data;

  UserDetailsModel({this.type, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'data': data?.toJson(),
    };
  }
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? country;
  String? phone;
  String? email;
  String? password;
  String? dob;
  String? gender;
  String? address; // Raw address string (JSON)
  String? image;
  String? school;
  String? syllabus;
  dynamic qualification;
  String? firebaseId;
  String? onesignalId;
  String? created;
  String? status;
  String? countryCode;

  // Parsed address fields
  String parsedAddress = '';
  String state = '';
  String zipCode = '';
  String parsedCountry = '';

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.country,
    this.phone,
    this.email,
    this.password,
    this.dob,
    this.gender,
    this.address,
    this.image,
    this.school,
    this.syllabus,
    this.qualification,
    this.firebaseId,
    this.onesignalId,
    this.created,
    this.status,
    this.countryCode,
  }) {
    _parseAddress();
  }

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    country = json['country'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    image = json['image'];
    school = json['school'];
    syllabus = json['syllabus'];
    qualification = json['qualification'];
    firebaseId = json['firebase_id'];
    onesignalId = json['onesignal_id'];
    created = json['created'];
    status = json['status'];
    countryCode = json['country_code'];

    _parseAddress();
  }

  void _parseAddress() {
    if (address != null && address!.isNotEmpty) {
      try {
        final decoded = jsonDecode(address!);
        parsedAddress = decoded['address'] ?? '';
        state = decoded['state'] ?? '';
        zipCode = decoded['zipCode'] ?? '';
        parsedCountry = decoded['country'] ?? '';
      } catch (e) {
        parsedAddress = '';
        state = '';
        zipCode = '';
        parsedCountry = '';
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'country': country,
      'phone': phone,
      'email': email,
      'password': password,
      'dob': dob,
      'gender': gender,
      'address': address,
      'image': image,
      'school': school,
      'syllabus': syllabus,
      'qualification': qualification,
      'firebase_id': firebaseId,
      'onesignal_id': onesignalId,
      'created': created,
      'status': status,
      'country_code': countryCode,
    };
  }
}
