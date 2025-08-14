class CourseClassesModel {
  String? type;
  List<Data>? data;
  String? message;

  CourseClassesModel({this.type, this.data, this.message});

  CourseClassesModel.fromJson(Map<String, dynamic> json) {
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
  String? packageClassId;
  String? packageid;
  String? packageClassStatus;
  String? className;
  String? classId;
  String? classDescription;
  String? classImage;

  Data(
      {this.packageClassId,
      this.packageid,
      this.packageClassStatus,
      this.className,
      this.classId,
      this.classDescription,
      this.classImage});

  Data.fromJson(Map<String, dynamic> json) {
    packageClassId = json['package_class_id'];
    packageid = json['packageid'];
    packageClassStatus = json['package_class_status'];
    className = json['class_name'];
    classId = json['class_id'];
    classDescription = json['class_description'];
    classImage = json['class_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_class_id'] = this.packageClassId;
    data['packageid'] = this.packageid;
    data['package_class_status'] = this.packageClassStatus;
    data['class_name'] = this.className;
    data['class_id'] = this.classId;
    data['class_description'] = this.classDescription;
    data['class_image'] = this.classImage;
    return data;
  }
}
