class VerifyPromoModel {
  String? type;
  String? message;
  int? finalAmount;

  VerifyPromoModel({this.type, this.message, this.finalAmount});

  VerifyPromoModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    finalAmount = json['final_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['final_amount'] = this.finalAmount;
    return data;
  }
}
