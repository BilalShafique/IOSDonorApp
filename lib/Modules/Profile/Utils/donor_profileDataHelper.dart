import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:donor_app/Modules/Dashboard/Model/home_model.dart';
import 'package:donor_app/Modules/Profile/Model/donor_profile_model.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/config.dart';
import 'package:donor_app/Shared/Utils/general_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

Future<String?> UpdateDonorProfile(
  DonorInfo? obj,
  List<XFile> imageList,
  BuildContext context,
) async {
  try {
    SessionMangement sm = SessionMangement();
    String? sessionId = await sm.getQalamSessionId();

    FormData formData = FormData();
    formData = FormData.fromMap({
      "id": obj!.id,
      "first_name": obj.name,
      "email": obj.email,
      "phone": obj.phone,
      "donor_category": obj.donor_category,
      "donor_country_id": obj.donor_country_id,
      "donor_city_id": obj.donor_city_id,
      "donor_geo_area_id": obj.donor_geo_area_id,
      "donor_sector_id": obj.donor_sector_id,
      "donor_category_type": obj.donor_category_type,
      "designation": obj.designation,
      "active": obj.active,
      "donor_organization": obj.organization,
    });
    if (imageList.isNotEmpty) {
      for (int i = 0; i < imageList.length; i++) {
        formData.files.addAll([
          MapEntry(
              "donor_image", await MultipartFile.fromFile(imageList[i].path)),
        ]);
      }
    }
    Dio dio = Dio();
    dio.options.headers["Cookie"] = sessionId;
    var response = await dio.post(
      '${qalamUrl}donor/update',
      data: formData,
    );
    /*  final response = await http.post(
      Uri.parse('${qalamUrl}donor/update'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Cookie': sessionId!
      },
      body: jsonEncode(requestMap),
    ); */

    if (response.statusCode == 200) {
      if (response.data["code"] == 400) {
        showInfoAlert("Error", response.data["message"], "", context);
        return "-1";
      } else {
        if (response.data["code"] == 200) {
          return "1";
        }
      }
    }
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<String?> SendFeedback(
    String subject, String description, int feedBackType) async {
  SessionMangement sm = SessionMangement();

  FeedBack modal = FeedBack();
  modal.subject = subject;
  modal.description = description;
  modal.donorcode = (await sm.getDonorCode())!;
  modal.feedBackType = feedBackType;
  try {
    final response = await http.post(
      Uri.parse('${baseUrl}Donor/SendFeedback'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(modal),
    );

    if (response.statusCode == 200) {
      // Map userMap = jsonDecode(response.body);
      // if (userMap["result"] == 200) {
      return "1";
      // }
    }

    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}
