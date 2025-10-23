import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/config.dart';

Future<List<DonorFund>?> getAllFunds() async {
  try {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();
    String? code = await sm.getDonorCode();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {
        "donor_code": code,
        "offset": 0,
        "limit": 15,
        "search_param": null
      },
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
      return list
          .skip(1)
          .map<DonorFund>((json) => DonorFund.fromJson(json))
          .toList();
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}
