class ForgotPasswordModel {
  String? type;
  String? otp;

  ForgotPasswordModel({this.type, this.otp});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['otp'] = this.otp;
    return data;
  }
}
