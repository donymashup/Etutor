class VideosModel {
  String? type;
  List<Data>? data;
  String? message;

  VideosModel({this.type, this.data, this.message});

  VideosModel.fromJson(Map<String, dynamic> json) {
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
  String? videoid;
  String? duration;
  String? link;
  String? hls;
  String? source;
  String? description;
  int? viewDuration;
  int? totalDuration;
  int? seek;

  Data(
      {this.id,
      this.name,
      this.thumbnail,
      this.videoid,
      this.duration,
      this.link,
      this.hls,
      this.source,
      this.description,
      this.viewDuration,
      this.totalDuration,
      this.seek});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    videoid = json['videoid'];
    duration = json['duration'];
    link = json['link'];
    hls = json['hls'];
    source = json['source'];
    description = json['description'];
    viewDuration = json['view_duration'];
    totalDuration = json['total_duration'];
    seek = json['seek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['videoid'] = this.videoid;
    data['duration'] = this.duration;
    data['link'] = this.link;
    data['hls'] = this.hls;
    data['source'] = this.source;
    data['description'] = this.description;
    data['view_duration'] = this.viewDuration;
    data['total_duration'] = this.totalDuration;
    data['seek'] = this.seek;
    return data;
  }
}
