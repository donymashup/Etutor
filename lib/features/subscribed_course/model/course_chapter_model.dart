class CourseChapterModel {
  String? type;
  List<Data>? data;
  String? message;

  CourseChapterModel({this.type, this.data, this.message});

  CourseChapterModel.fromJson(Map<String, dynamic> json) {
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
  String? packageChapterId;
  String? packageid;
  String? packageChapterStatus;
  String? chaptersName;
  String? chaptersId;
  String? chaptersDescription;
  String? chaptersImage;
  int? cpi;

  Data(
      {this.packageChapterId,
      this.packageid,
      this.packageChapterStatus,
      this.chaptersName,
      this.chaptersId,
      this.chaptersDescription,
      this.chaptersImage,
      this.cpi});

  Data.fromJson(Map<String, dynamic> json) {
    packageChapterId = json['package_chapter_id'];
    packageid = json['packageid'];
    packageChapterStatus = json['package_chapter_status'];
    chaptersName = json['chapters_name'];
    chaptersId = json['chapters_id'];
    chaptersDescription = json['chapters_description'];
    chaptersImage = json['chapters_image'];
    cpi = json['cpi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_chapter_id'] = this.packageChapterId;
    data['packageid'] = this.packageid;
    data['package_chapter_status'] = this.packageChapterStatus;
    data['chapters_name'] = this.chaptersName;
    data['chapters_id'] = this.chaptersId;
    data['chapters_description'] = this.chaptersDescription;
    data['chapters_image'] = this.chaptersImage;
    data['cpi'] = this.cpi;
    return data;
  }
}
