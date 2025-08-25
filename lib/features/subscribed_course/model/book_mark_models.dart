class BookMark {
  bool? type;

  BookMark({this.type});

  BookMark.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class checkForBookMark {
  bool? type;

  checkForBookMark({this.type});

  checkForBookMark.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}


class getUserBookmarkedContents {
  late String type;
  late List<Data> data;
  late String message;

  getUserBookmarkedContents({required this.type, required this.data, required this.message});

  getUserBookmarkedContents.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = <Data>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  late String id;
  late String userid;
  late String type;
  late String contentid;
  late String created;
  late String name;
  late String thumbnail;

  Data(
      {required this.id,
      required this.userid,
      required this.type,
      required this.contentid,
      required this.created,
      required this.name,
      required this.thumbnail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    type = json['type'];
    contentid = json['contentid'];
    created = json['created'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['type'] = this.type;
    data['contentid'] = this.contentid;
    data['created'] = this.created;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
