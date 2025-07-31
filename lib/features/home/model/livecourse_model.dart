class LiveCourseModel {
  String? type;
  List<Data>? data;

  LiveCourseModel({this.type, this.data});

  LiveCourseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  CourseDetails? courseDetails;
  PackageDetails? packageDetails;
  int? likesCount;
  int? commentsCount;
  List<String>? likedUserImages;
  double? avgStars;

  Data({
    this.courseDetails,
    this.packageDetails,
    this.likesCount,
    this.commentsCount,
    this.likedUserImages,
    this.avgStars,
  });

  Data.fromJson(Map<String, dynamic> json) {
    courseDetails = json['course_details'] != null
        ? CourseDetails.fromJson(json['course_details'])
        : null;
    packageDetails = json['package_details'] != null
        ? PackageDetails.fromJson(json['package_details'])
        : null;
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    likedUserImages = json['liked_user_images'] != null
        ? List<String>.from(json['liked_user_images'])
        : null;
    avgStars = json['avg_stars'] != null
        ? double.tryParse(json['avg_stars'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (courseDetails != null) {
      data['course_details'] = courseDetails!.toJson();
    }
    if (packageDetails != null) {
      data['package_details'] = packageDetails!.toJson();
    }
    data['likes_count'] = likesCount;
    data['comments_count'] = commentsCount;
    if (likedUserImages != null) {
      data['liked_user_images'] = likedUserImages;
    }
    data['avg_stars'] = avgStars;
    return data;
  }
}

class CourseDetails {
  String? id;
  String? name;
  String? start;
  String? end;
  String? type;
  String? level;
  String? syllabus;
  String? duration;
  String? image;
  String? price;
  String? discount;
  String? created;
  String? status;

  CourseDetails({
    this.id,
    this.name,
    this.start,
    this.end,
    this.type,
    this.level,
    this.syllabus,
    this.duration,
    this.image,
    this.price,
    this.discount,
    this.created,
    this.status,
  });

  CourseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
    type = json['type'];
    level = json['level'];
    syllabus = json['syllabus'];
    duration = json['duration'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start'] = start;
    data['end'] = end;
    data['type'] = type;
    data['level'] = level;
    data['syllabus'] = syllabus;
    data['duration'] = duration;
    data['image'] = image;
    data['price'] = price;
    data['discount'] = discount;
    data['created'] = created;
    data['status'] = status;
    return data;
  }
}

class PackageDetails {
  Package? package;
  List<Classes>? classes;
  List<Subjects>? subjects;
  List<Chapters>? chapters;

  PackageDetails({this.package, this.classes, this.subjects, this.chapters});

  PackageDetails.fromJson(Map<String, dynamic> json) {
    package =
        json['package'] != null ? Package.fromJson(json['package']) : null;
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(Classes.fromJson(v));
      });
    }
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (package != null) {
      data['package'] = package!.toJson();
    }
    if (classes != null) {
      data['classes'] = classes!.map((v) => v.toJson()).toList();
    }
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? id;
  String? name;
  String? description;
  String? created;
  String? status;

  Package({this.id, this.name, this.description, this.created, this.status});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created'] = created;
    data['status'] = status;
    return data;
  }
}

class Classes {
  String? packageClassId;
  String? className;

  Classes({this.packageClassId, this.className});

  Classes.fromJson(Map<String, dynamic> json) {
    packageClassId = json['package_class_id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['package_class_id'] = packageClassId;
    data['class_name'] = className;
    return data;
  }
}

class Subjects {
  String? packageSubjectId;
  String? subjectName;

  Subjects({this.packageSubjectId, this.subjectName});

  Subjects.fromJson(Map<String, dynamic> json) {
    packageSubjectId = json['package_subject_id'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['package_subject_id'] = packageSubjectId;
    data['subject_name'] = subjectName;
    return data;
  }
}

class Chapters {
  String? packageChapterId;
  String? chapterName;
  String? chapterId;

  Chapters({this.packageChapterId, this.chapterName, this.chapterId});

  Chapters.fromJson(Map<String, dynamic> json) {
    packageChapterId = json['package_chapter_id'];
    chapterName = json['chapter_name'];
    chapterId = json['chapter_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['package_chapter_id'] = packageChapterId;
    data['chapter_name'] = chapterName;
    data['chapter_id'] = chapterId;
    return data;
  }
}
