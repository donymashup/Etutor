class MyCourseModel {
  String? type;
  List<Data>? data;
  String? message;

  MyCourseModel({this.type, this.data, this.message});

  MyCourseModel.fromJson(Map<String, dynamic> json) {
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
  String? courseId;
  String? courseName;
  String? courseImage;
  String? enrollmentId;
  String? packageId;
  String? batchId;
  double? avgStars;

  Data(
      {this.courseId,
      this.courseName,
      this.courseImage,
      this.enrollmentId,
      this.packageId,
      this.batchId,
      this.avgStars});

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    courseImage = json['course_image'];
    enrollmentId = json['enrollment_id'];
    packageId = json['package_id'];
    batchId = json['batch_id'];
    avgStars = json['avg_stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_name'] = this.courseName;
    data['course_image'] = this.courseImage;
    data['enrollment_id'] = this.enrollmentId;
    data['package_id'] = this.packageId;
    data['batch_id'] = this.batchId;
    data['avg_stars'] = this.avgStars;
    return data;
  }
}
