class CourseClassesModel {
  String? type;
  List<ClassData>? data;
  String? message;

  CourseClassesModel({this.type, this.data, this.message});

  factory CourseClassesModel.fromJson(Map<String, dynamic> json) {
    return CourseClassesModel(
      type: json['type'],
      message: json['message'],
      data: json['data'] != null
          ? List<ClassData>.from(
              json['data'].map((x) => ClassData.fromJson(x)),
            )
          : [],
    );
  }
}

class ClassData {
  String? packageClassId;
  String? packageid;
  String? packageClassStatus;
  String? className;
  String? classId;
  String? classDescription;
  String? classImage;

  ClassData({
    this.packageClassId,
    this.packageid,
    this.packageClassStatus,
    this.className,
    this.classId,
    this.classDescription,
    this.classImage,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      packageClassId: json['package_class_id'],
      packageid: json['packageid'],
      packageClassStatus: json['package_class_status'],
      className: json['class_name'],
      classId: json['class_id'],
      classDescription: json['class_description'],
      classImage: json['class_image'],
    );
  }
}
