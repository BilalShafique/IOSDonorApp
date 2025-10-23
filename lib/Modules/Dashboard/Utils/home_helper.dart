import 'dart:convert';

import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

Future<DonorInfo?> getDonorInfo() async {
  try {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();
    String? code = await sm.getDonorCode();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"donor_code": code},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor/get'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      var data0 = DonorInfo.fromJson(data["result"]["data"]);
      if (data0.donor_pic != "") {
        data0.donor_pic = qalamImage + data0.donor_pic;
      }
      sm.setDonorName(data0.name);
      return data0;
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<List<DonorFund>?> getFunds() async {
  try {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();
    String? code = await sm.getDonorCode();
    final requestMap = {
      // 'jsonrpc': '2.0',
      // 'params': {
      "donor_code": code,
      "offset": 0,
      "limit": 15,
      "search_param": null,
      "order": "desc"
      // },
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}fund/get_all'),
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
      /*  return _list
        .skip(1)
        .map<DonorFund>((json) => DonorFund.fromJson(json))
        .toList(); */
      return list.map<DonorFund>((json) => DonorFund.fromJson(json)).toList();
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}
