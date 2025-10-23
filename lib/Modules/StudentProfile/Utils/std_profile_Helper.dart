import 'dart:convert';

import 'package:donor_app/Modules/FundDetail/Model/fundDetail_model.dart';
import 'package:donor_app/Modules/StudentProfile/Model/std_profile_model.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

Future<StudentModel?> getStudentDetail(int studentId) async {
  try {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();

    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"student_id": studentId},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor/get_student_detail'),
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
      var studentData = data["result"]["data"];
      var data0 = StudentModel.fromJson(studentData[0]);
      if (data0.student_pic != "") {
        data0.student_pic = qalamImage + data0.student_pic;
      }
      return data0;
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<List<TranscriptModel>?> getStudentTranscript(int studentId) async {
  try {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();

    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"student_id": studentId},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor/student_transcript'),
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
          .map<TranscriptModel>((json) => TranscriptModel.fromJson(json))
          .toList();
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<List<StudentBasic>?> geAllBeneficiary(String? stateFilter) async {
  try {
    SessionMangement sm = SessionMangement();

    String? sessionId = await sm.getQalamSessionId();
    String? code = await sm.getDonorCode();
    final requestMap = {
      'jsonrpc': '2.0',
      'params': {"donor_code": code, "state_filter": stateFilter},
    };

    final response = await http.post(
      Uri.parse('${qalamUrl}donor/all_students'),
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
