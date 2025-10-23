class AlumniInfo {
  String name;
  String photo;
  String city;
  String country;
  String gradyear;
  String batch;
  String degree;
  String currentDesignation;
  String currentOrganiztion;
  String currentIndustry;
  String discipline_long;
  List<AlumniEmployment>? employmentList;
  List<AlumniAchievement>? achievementList;

  AlumniInfo(
      {this.name = "",
      this.photo = "",
      this.city = "",
      this.country = "",
      this.gradyear = "",
      this.batch = "",
      this.degree = "",
      this.currentDesignation = "",
      this.currentOrganiztion = "",
      this.currentIndustry = "",
      this.discipline_long = "",
      this.employmentList,
      this.achievementList});

  factory AlumniInfo.fromJson(Map<dynamic, dynamic> json) {
    List<AlumniEmployment> empList = [];
    if (json['mvJobs'] != null) {
      var empObjsJson = json['mvJobs'] as List;
      empList =
          empObjsJson.map((json) => AlumniEmployment.fromJson(json)).toList();
    }
    List<AlumniAchievement> achivementList = [];
    if (json['mvAchivement'] != null) {
      var achivementObjsJson = json['mvAchivement'] as List;
      achivementList = achivementObjsJson
          .map((json) => AlumniAchievement.fromJson(json))
          .toList();
    }
    return AlumniInfo(
      name: json['name'] ?? "",
      photo: json['photo'] ?? "",
      city: json['city'] ?? "",
      country: json['country'] ?? "",
      gradyear: json['gradyear'] ?? "",
      batch: json['batch'] ?? "",
      degree: json['degree'] ?? "",
      discipline_long: json['discipline_long'] ?? "",
      employmentList: empList,
      achievementList: achivementList,
    );
  }
}

class AlumniEmployment {
  int iEmpId;
  String dtmFrom;
  String dtmTo;
  int bMentor;
  int bCurrentWorking;
  String currentDesignation;
  String currentOrganiztion;
  String currentIndustry;

  AlumniEmployment({
    this.iEmpId = 0,
    this.dtmFrom = "",
    this.dtmTo = "",
    this.bMentor = 0,
    this.bCurrentWorking = 0,
    this.currentDesignation = "",
    this.currentOrganiztion = "",
    this.currentIndustry = "",
  });

  factory AlumniEmployment.fromJson(Map<dynamic, dynamic> json) {
    return AlumniEmployment(
      iEmpId: json['iEmpId'] ?? 0,
      dtmFrom: json['dtmFrom'] ?? "",
      dtmTo: json['dtmTo'] ?? "",
      bMentor: json['bMentor'] ?? 0,
      bCurrentWorking: json['bCurrentWorking'] ?? 0,
      currentDesignation: json['currentDesignation'] ?? "",
      currentOrganiztion: json['currentOrganiztion'] ?? "",
      currentIndustry: json['currentIndustry'] ?? "",
    );
  }
}

class AlumniAchievement {
  String sTitle;
  String sDescription;

  AlumniAchievement({
    this.sTitle = "",
    this.sDescription = "",
  });

  factory AlumniAchievement.fromJson(Map<dynamic, dynamic> json) {
    return AlumniAchievement(
      sTitle: json['sTitle'] ?? "",
      sDescription: json['sDescription'] ?? "",
    );
  }
}
