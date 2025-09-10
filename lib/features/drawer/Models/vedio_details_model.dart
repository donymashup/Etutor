class VedioDetailsModel {
  String? id;
  String? name;
  String? thumbnail;
  String? videoid;
  String? duration;
  String? link;
  String? hls;
  String? source;
  String? description;
  String? created;
  String? status;

  VedioDetailsModel(
      {this.id,
      this.name,
      this.thumbnail,
      this.videoid,
      this.duration,
      this.link,
      this.hls,
      this.source,
      this.description,
      this.created,
      this.status});

  VedioDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    videoid = json['videoid'];
    duration = json['duration'];
    link = json['link'];
    hls = json['hls'];
    source = json['source'];
    description = json['description'];
    created = json['created'];
    status = json['status'];
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
    data['created'] = this.created;
    data['status'] = this.status;
    return data;
  }
}
