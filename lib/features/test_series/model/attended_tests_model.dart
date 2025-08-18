class AttendedTestsModel {
  String? type;
  List<Data>? data;
  String? message;

  AttendedTestsModel({this.type, this.data, this.message});

  AttendedTestsModel.fromJson(Map<String, dynamic> json) {
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
  String? testid;
  String? subTime;
  String? answerid;
  String? start;
  String? duration;
  String? name;

  Data(
      {this.testid,
      this.subTime,
      this.answerid,
      this.start,
      this.duration,
      this.name});

  Data.fromJson(Map<String, dynamic> json) {
    testid = json['testid'];
    subTime = json['sub_time'];
    answerid = json['answerid'];
    start = json['start'];
    duration = json['duration'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testid'] = this.testid;
    data['sub_time'] = this.subTime;
    data['answerid'] = this.answerid;
    data['start'] = this.start;
    data['duration'] = this.duration;
    data['name'] = this.name;
    return data;
  }
}
