class DonorInfo {
  int id;
  String name;
  String email;
  String phone;
  String organization;
  String country;
  String city;
  String geoarea;
  String sector;
  String designation;
  String donor_category;
  int donor_category_type;
  bool active;
  String donorCode;
  int noOfAdobted;
  int noOfStudent;
  int noOfAlumni;
  int donor_country_id;
  int donor_city_id;
  int donor_geo_area_id;
  int donor_sector_id;
  String donor_pic;
  DonorInfo(
      {this.id = 0,
      this.name = "",
      this.email = "",
      this.phone = "",
      this.organization = "",
      this.donor_category = "",
      this.donor_category_type = 0,
      this.country = "",
      this.city = "",
      this.geoarea = "",
      this.sector = "",
      this.designation = "",
      this.active = false,
      this.donorCode = "",
      this.noOfAdobted = 0,
      this.noOfStudent = 0,
      this.noOfAlumni = 0,
      this.donor_country_id = 0,
      this.donor_city_id = 0,
      this.donor_geo_area_id = 0,
      this.donor_sector_id = 0,
      this.donor_pic = ""});

  factory DonorInfo.fromJson(Map<dynamic, dynamic> json) {
    int parseInt(dynamic value) {
      // Convert the value to int if it's not null and not an empty string, otherwise return 0
      if (value is String && value.isEmpty) return 0;
      return value ?? 0;
    }

    int parseInt2(dynamic value) {
      // Convert the value to int if it's not null and not an empty string, otherwise return 0
      if (value is String && value.isEmpty) return 0;
      return int.parse(value);
    }

    return DonorInfo(
      id: json['id'] ?? 0,
      name: json['first_name'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      organization: json['donor_organization'] ?? "",
      donor_category_type: json['category_type']?['id'] ?? 0,
      country: json['country']['name'] ?? "",
      city: json['city']['name'] ?? "",
      geoarea: json['geoarea']['name'] ?? "",
      sector: json['sector']['name'] ?? "",
      donor_country_id: json['country']?['id'] ?? 0,
      donor_city_id: json['city']?['id'] ?? 0,
      donor_geo_area_id: json['geoarea']?['id'] ?? 0,
      donor_sector_id: json['sector']?['id'] ?? 0,
      designation: json['designation'] ?? 0,
      active: json['active'] ?? false,
      donorCode: json['donor_code'] ?? "",
      donor_category: json['donor_category'] ?? "",
      /* noOfAdobted: json['total_adopted_students'] ?? 0,
      noOfStudent: json['total_active_students'] ?? 0,
      noOfAlumni: json['total_alumni_students'] ?? 0, */
      noOfAdobted: parseInt(json['total_adopted_students']),
      noOfStudent: parseInt(json['total_active_students']),
      noOfAlumni: parseInt(json['total_alumni_students']),
      donor_pic: json['donor_pic'] ?? "",
    );
  }
}

class DonorFund {
  String id;
  String name;
  String code;
  String fund_nature1;
  int fund_type;
  String fund_type_desc;
  int association_type;
  String team_member_id;
  int particular;
  int region;
  int religion;
  String gender;
  int discipline;
  String parent_status;
  String zakat_eligibility;
  String tuition_fees;
  String stipend;
  String no_of_years;
  String student_allocation;
  int funding_scheme;
  String funding_amount;
  String description;
  String fund_year;
  int donor_id;
  String fund_creation_date;
  String active_students;
  String adopted_students;
  String alumni_students;
  String status_id;
  String t_amount;
  bool is_report;
  double closing_fund;
  int received_amount;
  List<PledgeInfo>? Pledgelist;

  DonorFund(
      {this.id = "",
      this.name = "",
      this.code = "",
      this.fund_nature1 = "",
      this.fund_type = 0,
      this.fund_type_desc = "",
      this.association_type = 0,
      this.team_member_id = "",
      this.particular = 0,
      this.region = 0,
      this.religion = 0,
      this.gender = "",
      this.discipline = 0,
      this.parent_status = "",
      this.zakat_eligibility = "",
      this.tuition_fees = "",
      this.stipend = "",
      this.no_of_years = "",
      this.student_allocation = "",
      this.funding_scheme = 0,
      this.funding_amount = "",
      this.description = "",
      this.fund_year = "",
      this.donor_id = 0,
      this.fund_creation_date = "",
      this.active_students = "",
      this.adopted_students = "",
      this.alumni_students = "",
      this.status_id = "",
      this.t_amount = "",
      this.is_report = false,
      this.closing_fund = 0.0,
      this.received_amount = 0,
      this.Pledgelist});

  factory DonorFund.fromJson(Map<dynamic, dynamic> json) {
    List<PledgeInfo> Pledgelist = [];
    if (json['pledge_ids'] != null) {
      var pledgeObjsJson = json['pledge_ids'] as List;
      Pledgelist =
          pledgeObjsJson.map((json) => PledgeInfo.fromJson(json)).toList();
    }

    return DonorFund(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      code: json['code'] ?? "",
      fund_nature1: json['fund_nature1'] ?? "",
      fund_type: json['fund_type'] ?? 0,
      fund_type_desc: json['fund_type_desc'] ?? "",
      //  association_type: json['association_type'] ?? 0,
      //  team_member_id: json['team_member_id'] ?? "",
      //  particular: json['particular'] ?? 0,
      // region: json['region'] ?? 0,
      //  religion: json['religion'] ?? 0,
      //  gender: json['gender'] ?? "",
      //  discipline: json['discipline'] ?? 0,
      //  parent_status: json['parent_status'] ?? "",
      //  zakat_eligibility: json['zakat_eligibility'] ?? "",
      //tuition_fees: json['tuition_fees'] ?? "",
      //stipend: json['stipend'] ?? "",
      //no_of_years: json['no_of_years'] ?? "",
      // student_allocation: json['student_allocation'] ?? "",
      // funding_scheme: json['funding_scheme'] ?? 0,
      funding_amount: json['funding_amount'] ?? "",
      //description: json['description'] ?? "",
      fund_year: json['fund_year'] ?? "",
      donor_id: (json['donor_id'] == false ||
              json['donor_id'] == null ||
              json['donor_id'] == '')
          ? 0
          : json['donor_id'],
      fund_creation_date: json['fund_creation_date'] ?? "",
      active_students: json['active_students'] ?? "",
      adopted_students: json['adopted_students'] ?? "",
      alumni_students: json['alumni_students'] ?? "",
      status_id: json['status_id'] ?? "",
      t_amount: json['t_amount'] ?? "",
      is_report: json['is_report'] ?? false,
      closing_fund: (json['closing_fund'] ?? 0).toDouble(),
      received_amount: json['received_amount'] ?? 0,

      Pledgelist: Pledgelist,
    );
  }
}

class PledgeInfo {
  int fund_id;
  String pledge_type;
  String pledge_period;
  String pledge_cycle;
  String transaction_date;
  String giving_method;
  String currency;
  String pledge_amount;
  String total_amount;
  String received_amount;
  String remaining_amount;

  PledgeInfo({
    this.fund_id = 0,
    this.pledge_type = "",
    this.pledge_period = "",
    this.pledge_cycle = "",
    this.transaction_date = "",
    this.giving_method = "",
    this.currency = "",
    this.pledge_amount = "",
    this.total_amount = "",
    this.received_amount = "",
    this.remaining_amount = "",
  });

  factory PledgeInfo.fromJson(Map<dynamic, dynamic> json) {
    return PledgeInfo(
      fund_id: json['fund_id'] ?? 0,
      pledge_type: json['pledge_type'] ?? "",
      pledge_period: json['pledge_period'] ?? "",
      pledge_cycle: json['pledge_cycle'] ?? "",
      transaction_date: json['transaction_date'] ?? "",
      giving_method: json['giving_method'] ?? "",
      currency: json['currency'] ?? "",
      pledge_amount: json['pledge_amount'] ?? "",
      total_amount: json['total_amount'] ?? "",
      received_amount: json['received_amount'] ?? "",
      remaining_amount: json['remaining_amount'] ?? "",
    );
  }
}
