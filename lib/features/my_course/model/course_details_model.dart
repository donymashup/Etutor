class CourseDetailsModal {
  String? type;
  Data? data;

  CourseDetailsModal({this.type, this.data});

  CourseDetailsModal.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CourseDetails? courseDetails;
  List<ExploreChapters>? exploreChapters;
  PackageDetails? packageDetails;
  List<Reviews>? reviews;

  Data(
      {this.courseDetails,
      this.exploreChapters,
      this.packageDetails,
      this.reviews});

  Data.fromJson(Map<String, dynamic> json) {
    courseDetails = json['course_details'] != null
        ? new CourseDetails.fromJson(json['course_details'])
        : null;
    if (json['explore_chapters'] != null) {
      exploreChapters = <ExploreChapters>[];
      json['explore_chapters'].forEach((v) {
        exploreChapters!.add(new ExploreChapters.fromJson(v));
      });
    }
    packageDetails = json['package_details'] != null
        ? new PackageDetails.fromJson(json['package_details'])
        : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseDetails != null) {
      data['course_details'] = this.courseDetails!.toJson();
    }
    if (this.exploreChapters != null) {
      data['explore_chapters'] =
          this.exploreChapters!.map((v) => v.toJson()).toList();
    }
    if (this.packageDetails != null) {
      data['package_details'] = this.packageDetails!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
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

  CourseDetails(
      {this.id,
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
      this.status});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start'] = this.start;
    data['end'] = this.end;
    data['type'] = this.type;
    data['level'] = this.level;
    data['syllabus'] = this.syllabus;
    data['duration'] = this.duration;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['created'] = this.created;
    data['status'] = this.status;
    return data;
  }
}

class ExploreChapters {
  String? chapId;
  String? chapName;
  String? chapImage;
  String? className;
  String? subjectName;
  List<Contents>? contents;

  ExploreChapters(
      {this.chapId,
      this.chapName,
      this.chapImage,
      this.className,
      this.subjectName,
      this.contents});

  ExploreChapters.fromJson(Map<String, dynamic> json) {
    chapId = json['chap_id'];
    chapName = json['chap_name'];
    chapImage = json['chap_image'];
    className = json['class_name'];
    subjectName = json['subject_name'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(new Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chap_id'] = this.chapId;
    data['chap_name'] = this.chapName;
    data['chap_image'] = this.chapImage;
    data['class_name'] = this.className;
    data['subject_name'] = this.subjectName;
    if (this.contents != null) {
      data['contents'] = this.contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  String? contentId;
  String? contentName;
  String? contentType;
  String? source;
  String? status;
  String? link;

  Contents(
      {this.contentId,
      this.contentName,
      this.contentType,
      this.source,
      this.status,
      this.link});

  Contents.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    contentName = json['content_name'];
    contentType = json['content_type'];
    source = json['source'];
    status = json['status'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_id'] = this.contentId;
    data['content_name'] = this.contentName;
    data['content_type'] = this.contentType;
    data['source'] = this.source;
    data['status'] = this.status;
    data['link'] = this.link;
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
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created'] = this.created;
    data['status'] = this.status;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_class_id'] = this.packageClassId;
    data['class_name'] = this.className;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_subject_id'] = this.packageSubjectId;
    data['subject_name'] = this.subjectName;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_chapter_id'] = this.packageChapterId;
    data['chapter_name'] = this.chapterName;
    data['chapter_id'] = this.chapterId;
    return data;
  }
}

class Reviews {
  String? id;
  String? courseid;
  String? userid;
  String? rating;
  String? comment;
  String? created;
  String? userName;
  String? image;

  Reviews(
      {this.id,
      this.courseid,
      this.userid,
      this.rating,
      this.comment,
      this.created,
      this.userName,
      this.image});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseid = json['courseid'];
    userid = json['userid'];
    rating = json['rating'];
    comment = json['comment'];
    created = json['created'];
    userName = json['user_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseid'] = this.courseid;
    data['userid'] = this.userid;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['created'] = this.created;
    data['user_name'] = this.userName;
    data['image'] = this.image;
    return data;
  }
}
