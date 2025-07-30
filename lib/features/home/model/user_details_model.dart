class UserDetailsModel {
  String? type;
  Data? data;

  UserDetailsModel({this.type, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
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
  String? address;
  String? image;
  String? school;
  String? syllabus;
  Null qualification;
  String? firebaseId;
  String? onesignalId;
  String? created;
  String? status;
  String? countryCode;

  Data(
      {this.id,
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
      this.countryCode});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['image'] = this.image;
    data['school'] = this.school;
    data['syllabus'] = this.syllabus;
    data['qualification'] = this.qualification;
    data['firebase_id'] = this.firebaseId;
    data['onesignal_id'] = this.onesignalId;
    data['created'] = this.created;
    data['status'] = this.status;
    data['country_code'] = this.countryCode;
    return data;
  }
}
