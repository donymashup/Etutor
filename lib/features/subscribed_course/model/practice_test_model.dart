class ChapterPraticeTestModel {
  String? type;
  List<Data>? data;
  String? message;

  ChapterPraticeTestModel({this.type, this.data, this.message});

  ChapterPraticeTestModel.fromJson(Map<String, dynamic> json) {
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
  String? thumbnail;
  int? duration;
  bool? attended;
  int? questionsCount;

  Data(
      {this.id,
      this.name,
      this.thumbnail,
      this.duration,
      this.attended,
      this.questionsCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    attended = json['attended'];
    questionsCount = json['questions_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['duration'] = this.duration;
    data['attended'] = this.attended;
    data['questions_count'] = this.questionsCount;
    return data;
  }
}
