class ChapterAnalysisModel {
  String? type;
  Data? data;
  String? message;

  ChapterAnalysisModel({this.type, this.data, this.message});

  ChapterAnalysisModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Tests? tests;
  Materials? materials;
  Materials? videos;
  int? overall;

  Data({this.tests, this.materials, this.videos, this.overall});

  Data.fromJson(Map<String, dynamic> json) {
    tests = json['tests'] != null ? new Tests.fromJson(json['tests']) : null;
    materials = json['materials'] != null
        ? new Materials.fromJson(json['materials'])
        : null;
    videos =
        json['videos'] != null ? new Materials.fromJson(json['videos']) : null;
    overall = json['overall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tests != null) {
      data['tests'] = this.tests!.toJson();
    }
    if (this.materials != null) {
      data['materials'] = this.materials!.toJson();
    }
    if (this.videos != null) {
      data['videos'] = this.videos!.toJson();
    }
    data['overall'] = this.overall;
    return data;
  }
}

class Tests {
  int? total;
  int? attended;
  Questions? questions;

  Tests({this.total, this.attended, this.questions});

  Tests.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    attended = json['attended'];
    questions = json['questions'] != null
        ? new Questions.fromJson(json['questions'])
        : null;
  }

  get unanswered => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['attended'] = this.attended;
    if (this.questions != null) {
      data['questions'] = this.questions!.toJson();
    }
    return data;
  }
}

class Questions {
  Count? count;
  Count? perCount;
  Count? time;
  Count? perTime;

  Questions({this.count, this.perCount, this.time, this.perTime});

  Questions.fromJson(Map<String, dynamic> json) {
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    perCount = json['per_count'] != null
        ? new Count.fromJson(json['per_count'])
        : null;
    time = json['time'] != null ? new Count.fromJson(json['time']) : null;
    perTime =
        json['per_time'] != null ? new Count.fromJson(json['per_time']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    if (this.perCount != null) {
      data['per_count'] = this.perCount!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    if (this.perTime != null) {
      data['per_time'] = this.perTime!.toJson();
    }
    return data;
  }
}

class Count {
  int? total;
  int? attended;
  int? correct;
  int? incorrect;
  int? unattended;

  Count(
      {this.total,
      this.attended,
      this.correct,
      this.incorrect,
      this.unattended});

  Count.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    attended = json['attended'];
    correct = json['correct'];
    incorrect = json['incorrect'];
    unattended = json['unattended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['attended'] = this.attended;
    data['correct'] = this.correct;
    data['incorrect'] = this.incorrect;
    data['unattended'] = this.unattended;
    return data;
  }
}

class Materials {
  int? viewed;
  int? total;
  int? per;

  Materials({this.viewed, this.total, this.per});

  Materials.fromJson(Map<String, dynamic> json) {
    viewed = json['viewed'];
    total = json['total'];
    per = json['per'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewed'] = this.viewed;
    data['total'] = this.total;
    data['per'] = this.per;
    return data;
  }
}
