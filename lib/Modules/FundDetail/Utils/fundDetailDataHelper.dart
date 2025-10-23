import 'dart:convert';
import 'package:donor_app/Modules/FundDetail/Model/fundDetail_model.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

Future<List<StudentBasic>?> getFundBeneficiary(String fundId) async {
  try {
    SessionMangement sm = SessionMangement();
    final int fundIdInt = int.parse(fundId);
    String? sessionId = await sm.getQalamSessionId();
    // String? code = await _sm.getDonorCode();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"fund_id": fundIdInt},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor/active/students'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    if (response.statusCode == 200) {
      //if (response.body != "null") {
      Map data = jsonDecode(response.body);
      List list;
      if (data["result"]["code"] == 404) {
        return null;
      } else {
        list = data["result"]["data"];
        return list
            .map<StudentBasic>((json) => StudentBasic.fromJson(json))
            .toList();
      }
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<List<StudentBasic>?> getFundAlumni(String fundId) async {
  try {
    SessionMangement sm = SessionMangement();
    final int fundIdInt = int.parse(fundId);
    String? sessionId = await sm.getQalamSessionId();
    // String? code = await _sm.getDonorCode();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"fund_id": fundIdInt},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor/alumni/students'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    if (response.statusCode == 200) {
      //if (response.body != "null") {
      Map data = jsonDecode(response.body);
      List list;
      if (data["result"]["code"] == 404) {
        return null;
      }
      list = data["result"]["data"];
      return list
          .map<StudentBasic>((json) => StudentBasic.fromJson(json))
          .toList();
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<List<FypDetail>?> getFundFyp(String fundId) async {
  try {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();
    // String? code = await _sm.getDonorCode();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {
        "fund_id": fundId,
        "offset": 0,
        "limit": 15,
        "search_param": null
      },
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor_fund_report/get_all'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    if (response.statusCode == 200) {
      //if (response.body != "null") {
      Map data = jsonDecode(response.body);
      List list;
      list = data["result"]["data"];
      return list.map<FypDetail>((json) => FypDetail.fromJson(json)).toList();
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<List<Pledge>?> getFundPledges(String fundId) async {
  try {
    SessionMangement sm = SessionMangement();
    final int fundIdInt = int.parse(fundId);
    String? sessionId = await sm.getQalamSessionId();
    // String? code = await _sm.getDonorCode();
    final requestMap = {
      // 'jsonrpc': '2.0',
      //'params': {
      "fund_id": fundIdInt
      //},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}pledge/get_all'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    if (response.statusCode == 200) {
      //if (response.body != "null") {
      Map data = jsonDecode(response.body);
      if (data["result"] != null) {
        List list;
        list = data["result"]["response"];
        return list.map<Pledge>((json) => Pledge.fromJson(json)).toList();
      }
      return null;
    }
    return null;
    /* } else {
      throw Exception('Failed to load Job Status');
    } */
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<List<TransactionList>?> getFundTransation(String fundId) async {
  try {
    SessionMangement sm = SessionMangement();
    final int fundIdInt = int.parse(fundId);
    String? sessionId = await sm.getQalamSessionId();
    // String? code = await _sm.getDonorCode();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"fund_id": fundIdInt},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor_fund_transactions'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      if (data["result"] != null) {
        List list;
        list = data["result"]["data"];

        return list
            .map<TransactionList>((json) => TransactionList.fromJson(json))
            .toList();
      }
      return null;
    }
    return null;
    /* } else {
      throw Exception('Failed to load Job Status');
    } */
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}
