class ResetPasswordModel {
  String? message;
  String? type;
  String? token;

  ResetPasswordModel({this.message, this.type, this.token});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    type = json['type'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['type'] = this.type;
    data['token'] = this.token;
    return data;
  }
}
