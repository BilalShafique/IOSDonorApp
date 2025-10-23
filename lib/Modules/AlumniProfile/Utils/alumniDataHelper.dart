import 'dart:convert';

import 'package:donor_app/Modules/AlumniProfile/Model/alumniprofile_model.dart';

import 'package:donor_app/Shared/Utils/config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

Future<AlumniInfo?> getAlumniDetail(String studentId) async {
  // SessionMangement _sm = SessionMangement();
  try {
    final response = await http.post(
      Uri.parse('${alumniApi}Alumni/getAlumni_jobinfo_donor?reg_no=$studentId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      var data0 = AlumniInfo.fromJson(data);
      if (data0.photo != "") {
        data0.photo = alumniImage + data0.photo;
      }
      return data0;
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}
