class SyllabusLiveCourseModel {
  String? type;
  List<Data>? data;
  String? message;

  SyllabusLiveCourseModel({this.type, this.data, this.message});

  SyllabusLiveCourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? price;
  String? image;
  Discount? discount;
  String? likesCount;
  String? avgStars;
  String? syllabus;

  Data(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.discount,
      this.likesCount,
      this.avgStars,
      this.syllabus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
    likesCount = json['likes_count'];
    avgStars = json['avg_stars'];
    syllabus = json['syllabus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    data['likes_count'] = this.likesCount;
    data['avg_stars'] = this.avgStars;
    data['syllabus'] = this.syllabus;
    return data;
  }
}

class Discount {
  String? type;
  String? value;

  Discount({this.type, this.value});

  Discount.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}
