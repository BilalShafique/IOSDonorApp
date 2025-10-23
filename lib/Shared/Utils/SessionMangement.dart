import 'package:shared_preferences/shared_preferences.dart';

class SessionMangement {
  late SharedPreferences prefs;

  setDonorCode(text) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString("donorCode", text);
  }

  Future<String?> getDonorCode() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    String? returnText = obj.getString("donorCode");
    return returnText;
  }

  removeDonorCode() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.remove("donorCode");
  }

  setDonorName(text) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString("donorName", text);
  }

  Future<String?> getDonorName() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    String? returnText = obj.getString("donorName");
    return returnText;
  }

  removeDonorName() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.remove("donorName");
  }

  setQalamSessionId(text) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString("sessionId", text);
  }

  Future<String?> getQalamSessionId() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    String? returnText = obj.getString("sessionId");
    return returnText;
  }

  removeQalamSessionId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.remove("sessionId");
  }

  setUserName(text) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString("userName", text);
  }

  setPassword(text) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString("password", text);
  }

  Future<String?> getPassword() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    String? returnText = obj.getString("password");
    return returnText;
  }

  Future<String?> getUserName() async {
    SharedPreferences obj = await SharedPreferences.getInstance();
    String? returnText = obj.getString("userName");
    return returnText;
  }

  removePassword() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.remove("password");
  }

  removeUserName() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.remove("userName");
  }
}
