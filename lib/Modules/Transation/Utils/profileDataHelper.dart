// ignore_for_file: import_of_legacy_library_into_null_safe,file_names
/* 
import 'dart:convert';

import 'package:flutter/material.dart'; */
/* Future<UserInfo?> login(String userNameController, String passwordController, bool rememberMe) async {

   try {

 SessionMangement _sm = SessionMangement();

  final requestMap = {
    'jsonrpc': '2.0',
    'params': { 
      "db": "ndrmf_dashboard",
        "login": userNameController,
        "password": passwordController
        },
  };
 final response = await http.post(
      Uri.parse(baseUrl + 'api/authenticate'),
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
       if(userMap["result"]==null)
       {
          return null;
       }
      var _data = UserInfo.fromJson(userMap["result"]);
     _sm.setSessionId(sessionid);
      if (rememberMe == true) {
        _sm.setPassword(passwordController);
        _sm.setEmail(userNameController);
        _sm.setUserName(_data.name);
        _sm.setUserId(_data.uId);
        _sm.setRememberMe(rememberMe);
       
      } 
      else
      {
         _sm.removeEmail();
        _sm.removePassword();
        _sm.removeRememberMe();
        _sm.removeUserId();
         _sm.removeUserName();

      }
     
      return _data; 
    } 
    return null;
  } catch (error) {
    EasyLoading.dismiss();
    throw Exception('Failed');
  } 
}


 Future<void> logout(BuildContext context) async {
  SessionMangement obj = SessionMangement();

  obj.removeSessionId();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (Route<dynamic> route) => false);
} */ 

  



