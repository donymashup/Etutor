class OrderIdModel {
  String? type;
  String? message;
  String? orderid;

  OrderIdModel({this.type, this.message, this.orderid});

  OrderIdModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    orderid = json['orderid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['orderid'] = this.orderid;
    return data;
  }
}
