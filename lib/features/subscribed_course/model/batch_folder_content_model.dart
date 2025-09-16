class BatchFolderContentModel {
  List<Folders>? folders;

  BatchFolderContentModel({this.folders});

  BatchFolderContentModel.fromJson(Map<String, dynamic> json) {
    if (json['folders'] != null) {
      folders = <Folders>[];
      json['folders'].forEach((v) {
        folders!.add(new Folders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.folders != null) {
      data['folders'] = this.folders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Folders {
  String? id;
  String? name;
  String? type;
  String? parentId;
  String? createdAt;
  String? contentid;
  String? batchid;
  String? link;
  String? thumbnail;
  String? duration;
  String? source;

  Folders(
      {this.id,
      this.name,
      this.type,
      this.parentId,
      this.createdAt,
      this.contentid,
      this.batchid,
      this.link,
      this.thumbnail,
      this.duration,
      this.source});

  Folders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    contentid = json['contentid'];
    batchid = json['batchid'];
    link = json['link'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['contentid'] = this.contentid;
    data['batchid'] = this.batchid;
    data['link'] = this.link;
    data['thumbnail'] = this.thumbnail;
    data['duration'] = this.duration;
    data['source'] = this.source;
    return data;
  }
}
