class CategoryBasedCoursesModel {
  final String? type;
  final String? message;
  final List<Data>? data;

  CategoryBasedCoursesModel({this.type, this.message, this.data});

  factory CategoryBasedCoursesModel.fromJson(Map<String, dynamic> json) {
    return CategoryBasedCoursesModel(
      type: json['type'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((v) => Data.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'message': message,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class Data {
  final String? id;
  final String? name;
  final List<Courses>? courses;
  final String? image;
  final String? description;
  final String? created;
  final String? status;

  Data({
    this.id,
    this.name,
    this.courses,
    this.image,
    this.description,
    this.created,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as String?,
      name: json['name'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((v) => Courses.fromJson(v as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      description: json['description'] as String?,
      created: json['created'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'courses': courses?.map((v) => v.toJson()).toList(),
      'image': image,
      'description': description,
      'created': created,
      'status': status,
    };
  }
}

class Courses {
  final CourseDetails? courseDetails;
  final String? categoryId;
  final String? categoryName;
  final double? avgStars;
  final bool? subscribed;
  final String? batchid;

  Courses({
    this.courseDetails,
    this.categoryId,
    this.categoryName,
    this.avgStars,
    this.subscribed,
    this.batchid,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      courseDetails: json['course_details'] != null
          ? CourseDetails.fromJson(json['course_details'])
          : null,
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      avgStars: (json['avg_stars'] != null)
          ? (json['avg_stars'] as num).toDouble()
          : null,
      subscribed: json['subscribed'] as bool?,
      batchid: json['batchid'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_details': courseDetails?.toJson(),
      'category_id': categoryId,
      'category_name': categoryName,
      'avg_stars': avgStars,
      'subscribed': subscribed,
      'batchid': batchid,
    };
  }
}

class CourseDetails {
  final String? id;
  final String? name;
  final String? start;
  final String? end;
  final String? type;
  final String? level;
  final String? syllabus;
  final String? duration;
  final String? image;
  final String? price;
  final String? discount;
  final String? created;
  final String? status;

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

  factory CourseDetails.fromJson(Map<String, dynamic> json) {
    return CourseDetails(
      id: json['id'] as String?,
      name: json['name'] as String?,
      start: json['start'] as String?,
      end: json['end'] as String?,
      type: json['type'] as String?,
      level: json['level'] as String?,
      syllabus: json['syllabus'] as String?,
      duration: json['duration'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
      discount: json['discount'] as String?,
      created: json['created'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start': start,
      'end': end,
      'type': type,
      'level': level,
      'syllabus': syllabus,
      'duration': duration,
      'image': image,
      'price': price,
      'discount': discount,
      'created': created,
      'status': status,
    };
  }
}
