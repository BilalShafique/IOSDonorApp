class StudentBasic {
  int student_id;
  String student_code;
  String student_name;
  String school_name;
  String current_semester;
  String email;
  String mobile;
  String passing_year;
  String status;

  StudentBasic({
    this.student_id = 0,
    this.student_code = "",
    this.student_name = "",
    this.school_name = "",
    this.current_semester = "",
    this.email = "",
    this.mobile = "",
    this.passing_year = "",
    this.status = "",
  });

  factory StudentBasic.fromJson(Map<dynamic, dynamic> json) {
    return StudentBasic(
        student_id: json['student_id'] ?? 0,
        student_code: json['student_code'] ?? "",
        student_name: json['student_name'] ?? "",
        school_name: json['school_name'] ?? "",
        current_semester: json['current_semester'] ?? "",
        email: json['email'] ?? "",
        mobile: json['mobile'] ?? "",
        passing_year: json['passing_year'] ?? "",
        status: json['status'] ?? "");
  }
}

class FypDetail {
  int id;
  int donor_id;
  String donor_name;
  int fund_id;
  String fund_name;
  String title;
  String fiscal_year_start;
  String fiscal_year_end;
  double donation_received;
  double income_during_fy;
  double scholarship_paid;
  double shared_service_cost;
  double net_surplus;
  double deficit;
  double closing_fund;
  String data_added_date;

  FypDetail({
    this.id = 0,
    this.donor_id = 0,
    this.donor_name = "",
    this.fund_id = 0,
    this.fund_name = "",
    this.title = "",
    this.fiscal_year_start = "",
    this.fiscal_year_end = "",
    this.donation_received = 0,
    this.income_during_fy = 0,
    this.scholarship_paid = 0,
    this.shared_service_cost = 0,
    this.net_surplus = 0,
    this.deficit = 0,
    this.closing_fund = 0,
    this.data_added_date = "",
  });

  factory FypDetail.fromJson(Map<dynamic, dynamic> json) {
    double parseInt(dynamic value) {
      // Convert the value to int if it's not null and not an empty string, otherwise return 0
      if (value is String && value.isEmpty) return 0;
      return value ?? 0;
    }

    return FypDetail(
      id: json['id'] ?? 0,
      donor_id: json['donor_id'] ?? 0,
      donor_name: json['donor_name'] ?? "",
      fund_id: json['fund_id'] ?? 0,
      fund_name: json['fund_name'] ?? "",
      title: json['title'] ?? "",
      fiscal_year_start: json['fiscal_year_start'] ?? "",
      fiscal_year_end: json['fiscal_year_end'] ?? "",
      donation_received: parseInt(json['donation_received']),
      income_during_fy: parseInt(json['income_during_fy']),
      scholarship_paid: parseInt(json['scholarship_paid']),
      shared_service_cost: parseInt(json['shared_service_cost']),
      net_surplus: parseInt(json['net_surplus']),
      deficit: parseInt(json['deficit']),
      closing_fund: parseInt(json['closing_fund']),
      data_added_date: json['data_added_date'] ?? "",
    );
  }
}

class Pledge {
  String id;
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
  List<PledgeCycle>? pledgeCycleList;

  Pledge({
    this.id = "",
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
    this.pledgeCycleList,
  });

  factory Pledge.fromJson(Map<dynamic, dynamic> json) {
    List<PledgeCycle>? item1;
    var item3 = json['pledge_cycle_ids'];
    if (item3 != null) {
      var item2 = json['pledge_cycle_ids'] as List;
      item1 = item2.map((dataJson) => PledgeCycle.fromJson(dataJson)).toList();
    }

    return Pledge(
      id: json['id'] ?? "",
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
      pledgeCycleList: item1,
    );
  }
}

class PledgeCycle {
  String id;
  int pledge_id;
  String pledge_cycle_lookup_id;
  String create_date_pc;
  String status;
  String amount_received;
  String total_amount;
  String amount_due_date;

  PledgeCycle({
    this.id = "",
    this.pledge_id = 0,
    this.pledge_cycle_lookup_id = "",
    this.create_date_pc = "",
    this.status = "",
    this.amount_received = "",
    this.total_amount = "",
    this.amount_due_date = "",
  });

  factory PledgeCycle.fromJson(Map<dynamic, dynamic> json) {
    return PledgeCycle(
      id: json['id'] ?? "",
      pledge_id: json['pledge_id'] ?? "",
      pledge_cycle_lookup_id: json['pledge_cycle_lookup_id'] ?? "",
      create_date_pc: json['create_date_pc'] ?? "",
      status: json['status'] ?? "",
      amount_received: json['amount_received'] ?? "",
      total_amount: json['total_amount'] ?? "",
      amount_due_date: json['amount_due_date'] ?? "",
    );
  }
}

class Transaction {
  String transaction_date;
  String created_date;
  double transaction_amount;
  String donor_code;
  String currency;
  String mode;
  int transaction_type;
  String regular_type;
  int bank_account;
  String receipt_number;
  int status;
  String transaction_confirmation;
  String comments;
  String sub_transaction_type;

  Transaction({
    this.transaction_date = "",
    this.created_date = "",
    this.transaction_amount = 0,
    this.donor_code = "",
    this.currency = "",
    this.mode = "",
    this.transaction_type = 0,
    this.regular_type = "",
    this.bank_account = 0,
    this.receipt_number = "",
    this.status = 0,
    this.transaction_confirmation = "",
    this.comments = "",
    this.sub_transaction_type = "",
  });

  factory Transaction.fromJson(Map<dynamic, dynamic> json) {
    return Transaction(
      transaction_date: json['transaction_date'] ?? "",
      created_date: json['created_date'] ?? "",
      transaction_amount: json['transaction_amount'] ?? 0,
      donor_code: json['donor_code'] ?? "",
      currency: json['currency'] ?? "",
      mode: json['mode'] ?? "",
      transaction_type: json['transaction_type'] ?? 0,
      regular_type: json['regular_type'] ?? "",
      bank_account: json['bank_account'] ?? 0,
      receipt_number: json['receipt_number'] ?? "",
      status: json['status'] ?? 0,
      transaction_confirmation: json['transaction_confirmation'] ?? "",
      comments: json['comments'] ?? "",
      sub_transaction_type: json['sub_transaction_type'] ?? "",
    );
  }
}

class TransactionList {
  Transaction? transaction;
  TransactionDetail? transactionDetail;

  TransactionList({this.transaction, this.transactionDetail});

  factory TransactionList.fromJson(Map<dynamic, dynamic> json) {
    return TransactionList(
      transaction: json['transaction'] != null
          ? Transaction.fromJson(json['transaction'])
          : null,
      transactionDetail: json['detail'] != null
          ? TransactionDetail.fromJson(json['detail'])
          : null,
    );
  }
}

class TransactionDetail {
  String fund_id;
  int transaction_id;
  int assigned_amount;

  TransactionDetail({
    this.fund_id = "",
    this.transaction_id = 0,
    this.assigned_amount = 0,
  });

  factory TransactionDetail.fromJson(Map<dynamic, dynamic> json) {
    return TransactionDetail(
      fund_id: json['fund_id'] ?? "",
      transaction_id: json['transaction_id'] ?? 0,
      assigned_amount: json['assigned_amount'] ?? 0,
    );
  }
}
