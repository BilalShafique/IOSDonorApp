import 'dart:convert';
import 'package:donor_app/Modules/Auth/UI/login.dart';
import 'package:donor_app/Shared/Utils/SessionMangement.dart';
import 'package:donor_app/Shared/Utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:donor_app/Modules/Auth/Model/auth_model.dart';

Future<AuthResponse?> Donorlogin(
    String userNameController, String passwordController) async {
  try {
    SignIn modal = SignIn();
    modal.email = userNameController;
    modal.password = passwordController;

    final response = await http.post(
      Uri.parse('${baseUrl}Account/DonorLogin'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(modal),
    );
    if (response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      var data = AuthResponse.fromJson(userMap);
      SessionMangement sm = SessionMangement();
      if (data.isAuthSuccessful == true) {
        sm.setDonorCode(data.donorCode);
        sm.setUserName(modal.email);
        sm.setPassword(modal.password);
        await qalamAuthentication();
      }
      return data;
    }

    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}

Future<void> qalamAuthentication() async {
  try {
    SessionMangement sm = SessionMangement();

    final requestMap = {
      'jsonrpc': '2.0',
      'params': {
        "db": "cms_production",
        "login": "impact.user",
        "password": "@piu\$er"
      },
    };

    /*  final requestMap = {
    'jsonrpc': '2.0',
    'params': {
      "db": "democms_30102023",
      "login": "impact.ict",
      "password": "123"
    },
  }; */
    final response = await http.post(
      Uri.parse('${qalamUrl}api/authenticate'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(requestMap),
    );

    if (response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);
      String? cookies = response.headers['set-cookie'];
      List<String> cookieString = cookies!.split(';');
      String sessionid = cookieString[0];
      if (userMap["result"] == null) {
        return;
      }
      UserInfo.fromJson(userMap["result"]);
      sm.setQalamSessionId(sessionid);
    }
  } catch (error) {
    EasyLoading.dismiss();
    return;
  }
}

Future<void> logout(BuildContext context) async {
  SessionMangement obj = SessionMangement();

  obj.removeDonorCode();
  obj.removeQalamSessionId();
  obj.removeDonorName();
  obj.removePassword();
  obj.removeUserName();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (Route<dynamic> route) => false);
}

Future<String?> changePassword(ChangePasswordModel modal) async {
  try {
    SessionMangement sm = SessionMangement();
    modal.donorCode = (await sm.getDonorCode())!;
    final response = await http.post(
      Uri.parse('${baseUrl}Account/ChangePassword'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(modal),
    );
    if (response.statusCode == 200) {
      Map userMap = jsonDecode(response.body);

      if (userMap["id"] == 1) {
        return "1";
      }
    } else if (response.statusCode == 400) {
      Map userMap = jsonDecode(response.body);

      if (userMap["errors"]["ConfirmPassword"] != null &&
          userMap["errors"]["ConfirmPassword"].isNotEmpty) {
        return userMap["errors"]["ConfirmPassword"][0];
      }
      return userMap["errors"][0];
    }

    return null;
  } catch (error) {
    EasyLoading.dismiss();
    return null;
  }
}
