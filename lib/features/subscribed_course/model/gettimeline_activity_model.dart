class GetTimelineActivityModel {
  String? type;
  String? message;
  List<Data>? data;

  GetTimelineActivityModel({this.type, this.message, this.data});

  GetTimelineActivityModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = (json['data'] as List)
          .map((v) => Data.fromJson(v))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['type'] = type;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    return result;
  }
}

class Data {
  String? id;
  String? type;
  String? userid;
  String? contentid;
  String? time;
  String? contentName;
  String? contentType;
  String? thumbnail;
  String? link;

  Data({
    this.id,
    this.type,
    this.userid,
    this.contentid,
    this.time,
    this.contentName,
    this.contentType,
    this.thumbnail,
    this.link,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userid = json['userid'];
    contentid = json['contentid'];
    time = json['time'];
    contentName = json['content_name'];
    contentType = json['content_type'];
    thumbnail = json['thumbnail'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['id'] = id;
    result['type'] = type;
    result['userid'] = userid;
    result['contentid'] = contentid;
    result['time'] = time;
    result['content_name'] = contentName;
    result['content_type'] = contentType;
    result['thumbnail'] = thumbnail;
    result['link'] = link;
    return result;
  }
}
