class PromoCodeModel {
  String? type;
  String? message;
  List<Data>? data;

  PromoCodeModel({this.type, this.message, this.data});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? code;
  String? type;
  String? value;
  String? expiry;
  String? status;

  Data({this.id, this.code, this.type, this.value, this.expiry, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    type = json['type'];
    value = json['value'];
    expiry = json['expiry'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['type'] = this.type;
    data['value'] = this.value;
    data['expiry'] = this.expiry;
    data['status'] = this.status;
    return data;
  }
}
