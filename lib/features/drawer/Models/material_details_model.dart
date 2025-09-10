class MaterialDetailsModel {
  String? id;
  String? name;
  String? link;
  String? description;
  String? created;
  String? status;

  MaterialDetailsModel(
      {this.id,
      this.name,
      this.link,
      this.description,
      this.created,
      this.status});

  MaterialDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    description = json['description'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    data['description'] = this.description;
    data['created'] = this.created;
    data['status'] = this.status;
    return data;
  }
}
