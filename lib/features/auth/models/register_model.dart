class RegisterModel {
  String? message;
  String? type;
  String? token;
  int? userId;

  RegisterModel({this.message, this.type, this.token, this.userId});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    token = json['token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    return data;
  }
}
