class DropDownOptionModel {
  String? type;
  Data? data;

  DropDownOptionModel({this.type, this.data});

  DropDownOptionModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Syllabus>? syllabus;
  List<Classes>? classes;

  Data({this.syllabus, this.classes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['syllabus'] != null) {
      syllabus = <Syllabus>[];
      json['syllabus'].forEach((v) {
        syllabus!.add(new Syllabus.fromJson(v));
      });
    }
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.syllabus != null) {
      data['syllabus'] = this.syllabus!.map((v) => v.toJson()).toList();
    }
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Syllabus {
  String? id;
  String? name;
  String? status;

  Syllabus({this.id, this.name, this.status});

  Syllabus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class Classes {
  String? id;
  String? name;
  String? image;
  String? description;
  String? created;
  String? status;

  Classes(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.created,
      this.status});

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['created'] = this.created;
    data['status'] = this.status;
    return data;
  }
}