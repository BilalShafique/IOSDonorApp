class StudentModel {
  int student_id;
  String student_pic;
  String student_name;
  String school_name;
  String discipine_id;
  String current_program;
  String current_semester;
  double curr_cgpa;
  String batch_id;
  String father_prof;
  int father_income;
  String province;
  String city;
  List<CGPAModel>? cgpa_list;

  StudentModel({
    this.student_id = 0,
    this.student_pic = "",
    this.student_name = "",
    this.school_name = "",
    this.discipine_id = "",
    this.current_program = "",
    this.current_semester = "",
    this.curr_cgpa = 0,
    this.batch_id = "",
    this.father_prof = "",
    this.father_income = 0,
    this.province = "",
    this.city = "",
    this.cgpa_list,
  });

  factory StudentModel.fromJson(Map<dynamic, dynamic> json) {
    List<CGPAModel>? item1;
    var item3 = json['cgpa_list'];
    if (item3 != null) {
      var item2 = json['cgpa_list'] as List;
      item1 = item2.map((dataJson) => CGPAModel.fromJson(dataJson)).toList();
    }

    return StudentModel(
      student_id: json['student_id'] ?? 0,
      student_pic: json['student_pic'] ?? "",
      student_name: json['student_name'] ?? "",
      school_name: json['school_name'] ?? "",
      discipine_id: json['discipine_id'] ?? "",
      current_program: json['current_program'] ?? "",
      current_semester: json['current_semester'] ?? "",
      curr_cgpa: json['curr_cgpa'] ?? "",
      batch_id: json['batch_id'] ?? "",
      father_prof: json['father_prof'] ?? "",
      father_income:
          json['father_income'] is int ? json['father_income'] ?? 0 : 0,
      province: json['province'] ?? "",
      city: json['city'] ?? "",
      cgpa_list: item1,
    );
  }
}

class CGPAModel {
  String semester;
  String code;
  double cgpa;

  CGPAModel({this.semester = "", this.code = "", this.cgpa = 0});

  factory CGPAModel.fromJson(Map<dynamic, dynamic> json) {
    double parseInt(dynamic value) {
      // Convert the value to int if it's not null and not an empty string, otherwise return 0
      if (value is String && value.isEmpty) return 0;
      return value ?? 0;
    }

    return CGPAModel(
        semester: json['semester_name'] ?? "",
        code: json['semester_code'] ?? "",
        cgpa: parseInt(json['sgpa']));
  }
}

class TranscriptModel {
  String term_name;
  int term_id;
  List<Subject>? subjects;

  TranscriptModel({
    this.term_name = "",
    this.term_id = 0,
    this.subjects,
  });

  factory TranscriptModel.fromJson(Map<dynamic, dynamic> json) {
    List<Subject>? item1;
    var item3 = json['subjects'];
    if (item3 != null) {
      var item2 = json['subjects'] as List;
      item1 = item2.map((dataJson) => Subject.fromJson(dataJson)).toList();
    }
    return TranscriptModel(
      term_name: json['term_name'] ?? "",
      term_id: json['term_id'] ?? 0,
      subjects: item1,
    );
  }
}

class Subject {
  String course_name;
  String grade;

  Subject({this.course_name = "", this.grade = ""});

  factory Subject.fromJson(Map<dynamic, dynamic> json) {
    return Subject(
      course_name: json['course_name'] ?? "",
      grade: json['grade'] ?? "",
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  String x;
  double y;
}
