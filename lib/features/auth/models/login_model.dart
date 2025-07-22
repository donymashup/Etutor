class LoginModel {
  String? type;
  String? userid;
  String? message;

  LoginModel({this.type, this.userid, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    userid = json['userid'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['userid'] = this.userid;
    data['message'] = this.message;
    return data;
  }
}