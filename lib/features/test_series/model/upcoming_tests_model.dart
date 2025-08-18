class UpcomingTestsModel {
  String? type;
  List<Data>? data;
  String? message;

  UpcomingTestsModel({this.type, this.data, this.message});

  UpcomingTestsModel.fromJson(Map<String, dynamic> json) {
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
  int? totalDuration;
  int? questionsCount;
  bool? attended;
  String? startTime;
  String? endTime;
  String? syllabus;
  String? description;

  Data(
      {this.id,
      this.name,
      this.totalDuration,
      this.questionsCount,
      this.attended,
      this.startTime,
      this.endTime,
      this.syllabus,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalDuration = json['total_duration'];
    questionsCount = json['questions_count'];
    attended = json['attended'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    syllabus = json['syllabus'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_duration'] = this.totalDuration;
    data['questions_count'] = this.questionsCount;
    data['attended'] = this.attended;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['syllabus'] = this.syllabus;
    data['description'] = this.description;
    return data;
  }
}
