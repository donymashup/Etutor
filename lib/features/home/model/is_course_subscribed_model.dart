class IsCouseSubscribedModel {
  String? type;
  bool? data;
  String? message;

  IsCouseSubscribedModel({this.type, this.data, this.message});

  IsCouseSubscribedModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}