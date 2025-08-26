class ExamPerformanceModel {
  ExamDetails examDetails;
  UserDetails userDetails;
  Time time;
  Map<String, SectionAnalysis> sectionAnalysis;
  List<SubjectAnalysis> subjectAnalysis;

  ExamPerformanceModel({
    required this.examDetails,
    required this.userDetails,
    required this.time,
    required this.sectionAnalysis,
    required this.subjectAnalysis,
  });

  factory ExamPerformanceModel.fromJson(Map<String, dynamic> json) {
    return ExamPerformanceModel(
      examDetails: ExamDetails.fromJson(json['exam_details']),
      userDetails: UserDetails.fromJson(json['user_details']),
      time: Time.fromJson(json['time']),
      sectionAnalysis: (json['section_analysis'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, SectionAnalysis.fromJson(value)),
      ),
      subjectAnalysis: (json['subject_analysis'] as List)
          .map((e) => SubjectAnalysis.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_details': examDetails.toJson(),
      'user_details': userDetails.toJson(),
      'time': time.toJson(),
      'section_analysis':
          sectionAnalysis.map((key, value) => MapEntry(key, value.toJson())),
      'subject_analysis': subjectAnalysis.map((e) => e.toJson()).toList(),
    };
  }
}

class ExamDetails {
  String title;
  int totalQuestions;
  String duration;
  String ranklistPublished;
  String answersheetPublished;
  String performance;
  int maxMark;
  List<String> subjects;
  int topper;
  int average;
  String mode;
  int topperPercentage;
  int averagePercentage;

  ExamDetails({
    required this.title,
    required this.totalQuestions,
    required this.duration,
    required this.ranklistPublished,
    required this.answersheetPublished,
    required this.performance,
    required this.maxMark,
    required this.subjects,
    required this.topper,
    required this.average,
    required this.mode,
    required this.topperPercentage,
    required this.averagePercentage,
  });

  factory ExamDetails.fromJson(Map<String, dynamic> json) {
    return ExamDetails(
      title: json['title'],
      totalQuestions: (json['total_questions'] as num).toInt(),
      duration: json['duration'],
      ranklistPublished: json['ranklist_published'],
      answersheetPublished: json['answersheet_published'],
      performance: json['performance'],
      maxMark: (json['max_mark'] as num).toInt(),
      subjects: List<String>.from(json['subjects']),
      topper: (json['topper'] as num).toInt(),
      average: (json['average'] as num).toInt(),
      mode: json['mode'],
      topperPercentage: (json['topper_percentage'] as num).toInt(),
      averagePercentage: (json['average_percentage'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'total_questions': totalQuestions,
      'duration': duration,
      'ranklist_published': ranklistPublished,
      'answersheet_published': answersheetPublished,
      'performance': performance,
      'max_mark': maxMark,
      'subjects': subjects,
      'topper': topper,
      'average': average,
      'mode': mode,
      'topper_percentage': topperPercentage,
      'average_percentage': averagePercentage,
    };
  }
}

class UserDetails {
  int positiveMarks;
  int negativeMarks;
  int questionsAnswered;
  int correctlyAnswered;
  int incorrectlyAnswered;
  int attendedQuestion;
  int questionsUnAttended;
  int questionsUnAnswered;
  int score;
  int rank;
  double averageTime;
  int accuracy;
  int percentageScore;
  String result;

  UserDetails({
    required this.positiveMarks,
    required this.negativeMarks,
    required this.questionsAnswered,
    required this.correctlyAnswered,
    required this.incorrectlyAnswered,
    required this.attendedQuestion,
    required this.questionsUnAttended,
    required this.questionsUnAnswered,
    required this.score,
    required this.rank,
    required this.averageTime,
    required this.accuracy,
    required this.percentageScore,
    required this.result,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      positiveMarks: (json['positive_marks'] as num).toInt(),
      negativeMarks: (json['negative_marks'] as num).toInt(),
      questionsAnswered: (json['questions_answered'] as num).toInt(),
      correctlyAnswered: (json['correctly_answered'] as num).toInt(),
      incorrectlyAnswered: (json['incorrectly_answered'] as num).toInt(),
      attendedQuestion: (json['attended_question'] as num).toInt(),
      questionsUnAttended: (json['questions_un_attended'] as num).toInt(),
      questionsUnAnswered: (json['questions_un_answered'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      averageTime: (json['average_time'] as num).toDouble(),
      accuracy: (json['accuracy'] as num).toInt(),
      percentageScore: (json['percentage_score'] as num).toInt(),
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'positive_marks': positiveMarks,
      'negative_marks': negativeMarks,
      'questions_answered': questionsAnswered,
      'correctly_answered': correctlyAnswered,
      'incorrectly_answered': incorrectlyAnswered,
      'attended_question': attendedQuestion,
      'questions_un_attended': questionsUnAttended,
      'questions_un_answered': questionsUnAnswered,
      'score': score,
      'rank': rank,
      'average_time': averageTime,
      'accuracy': accuracy,
      'percentage_score': percentageScore,
      'result': result,
    };
  }
}

class Time {
  int totalTimeTaken;
  int correct;
  int incorrect;
  int unanswered;
  double avgCorrect;
  double avgIncorrect;
  double avgUnanswered;

  Time({
    required this.totalTimeTaken,
    required this.correct,
    required this.incorrect,
    required this.unanswered,
    required this.avgCorrect,
    required this.avgIncorrect,
    required this.avgUnanswered,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      totalTimeTaken: (json['total_time_taken'] as num).toInt(),
      correct: (json['correct'] as num).toInt(),
      incorrect: (json['incorrect'] as num).toInt(),
      unanswered: (json['unanswered'] as num).toInt(),
      avgCorrect: (json['avg_correct'] as num).toDouble(),
      avgIncorrect: (json['avg_incorrect'] as num).toDouble(),
      avgUnanswered: (json['avg_unanswered'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_time_taken': totalTimeTaken,
      'correct': correct,
      'incorrect': incorrect,
      'unanswered': unanswered,
      'avg_correct': avgCorrect,
      'avg_incorrect': avgIncorrect,
      'avg_unanswered': avgUnanswered,
    };
  }
}

class SectionAnalysis {
  String title;
  String id;
  Count count;
  TimeAnalysis time;

  SectionAnalysis({
    required this.title,
    required this.id,
    required this.count,
    required this.time,
  });

  factory SectionAnalysis.fromJson(Map<String, dynamic> json) {
    return SectionAnalysis(
      title: json['title'],
      id: json['id'],
      count: Count.fromJson(json['count']),
      time: TimeAnalysis.fromJson(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'count': count.toJson(),
      'time': time.toJson(),
    };
  }
}

class Count {
  int correct;
  int incorrect;
  int unattempted;
  int unattended;
  int total;
  double perCorrect;
  double perIncorrect;
  double perUnattempted;
  double perUnattended;

  Count({
    required this.correct,
    required this.incorrect,
    required this.unattempted,
    required this.unattended,
    required this.total,
    required this.perCorrect,
    required this.perIncorrect,
    required this.perUnattempted,
    required this.perUnattended,
  });

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      correct: (json['correct'] as num).toInt(),
      incorrect: (json['incorrect'] as num).toInt(),
      unattempted: (json['unattempted'] as num).toInt(),
      unattended: (json['unattended'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      perCorrect: (json['per_correct'] as num).toDouble(),
      perIncorrect: (json['per_incorrect'] as num).toDouble(),
      perUnattempted: (json['per_unattempted'] as num).toDouble(),
      perUnattended: (json['per_unattended'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'incorrect': incorrect,
      'unattempted': unattempted,
      'unattended': unattended,
      'total': total,
      'per_correct': perCorrect,
      'per_incorrect': perIncorrect,
      'per_unattempted': perUnattempted,
      'per_unattended': perUnattended,
    };
  }
}

class TimeAnalysis {
  int correct;
  int incorrect;
  int unanswered;
  int total;
  double perCorrect;
  double perIncorrect;
  double perUnattempted;

  TimeAnalysis({
    required this.correct,
    required this.incorrect,
    required this.unanswered,
    required this.total,
    required this.perCorrect,
    required this.perIncorrect,
    required this.perUnattempted,
  });

  factory TimeAnalysis.fromJson(Map<String, dynamic> json) {
    return TimeAnalysis(
      correct: (json['correct'] as num).toInt(),
      incorrect: (json['incorrect'] as num).toInt(),
      unanswered: (json['unanswered'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      perCorrect: (json['per_correct'] as num).toDouble(),
      perIncorrect: (json['per_incorrect'] as num).toDouble(),
      perUnattempted: (json['per_unattempted'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'incorrect': incorrect,
      'unanswered': unanswered,
      'total': total,
      'per_correct': perCorrect,
      'per_incorrect': perIncorrect,
      'per_unattempted': perUnattempted,
    };
  }
}

class SubjectAnalysis {
  String title;
  Count count;
  TimeAnalysis time;

  SubjectAnalysis({
    required this.title,
    required this.count,
    required this.time,
  });

  factory SubjectAnalysis.fromJson(Map<String, dynamic> json) {
    return SubjectAnalysis(
      title: json['title'],
      count: Count.fromJson(json['count']),
      time: TimeAnalysis.fromJson(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'count': count.toJson(),
      'time': time.toJson(),
    };
  }
}
