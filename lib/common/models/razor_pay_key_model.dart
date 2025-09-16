class RazorPayKeyModel {
  String? key;
  String? type;

  RazorPayKeyModel({this.key, this.type});

  RazorPayKeyModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['type'] = this.type;
    return data;
  }
}
