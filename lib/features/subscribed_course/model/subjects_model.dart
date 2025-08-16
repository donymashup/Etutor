class SubjectsModel {
  String? type;
  List<Data>? data;
  String? message;

  SubjectsModel({this.type, this.data, this.message});

  SubjectsModel.fromJson(Map<String, dynamic> json) {
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
  String? packageSubjectId;
  String? packageid;
  String? packageSubjectStatus;
  String? subjectName;
  String? subjectId;
  String? subjectDescription;
  String? subjectImage;

  Data(
      {this.packageSubjectId,
      this.packageid,
      this.packageSubjectStatus,
      this.subjectName,
      this.subjectId,
      this.subjectDescription,
      this.subjectImage});

  Data.fromJson(Map<String, dynamic> json) {
    packageSubjectId = json['package_subject_id'];
    packageid = json['packageid'];
    packageSubjectStatus = json['package_subject_status'];
    subjectName = json['subject_name'];
    subjectId = json['subject_id'];
    subjectDescription = json['subject_description'];
    subjectImage = json['subject_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_subject_id'] = this.packageSubjectId;
    data['packageid'] = this.packageid;
    data['package_subject_status'] = this.packageSubjectStatus;
    data['subject_name'] = this.subjectName;
    data['subject_id'] = this.subjectId;
    data['subject_description'] = this.subjectDescription;
    data['subject_image'] = this.subjectImage;
    return data;
  }
}
