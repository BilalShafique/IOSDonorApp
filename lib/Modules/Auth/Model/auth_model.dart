class UserInfo {
  int uId;
  String name;
  String username;
  String partnerDisplayName;
  int companyId;
  int partnerId;
  bool isAdmin;
  bool isSystem;

  UserInfo(
      {this.uId = 0,
      this.name = "",
      this.username = "",
      this.partnerDisplayName = "",
      this.companyId = 0,
      this.partnerId = 0,
      this.isAdmin = false,
      this.isSystem = false});

  factory UserInfo.fromJson(Map<dynamic, dynamic> json) {
    return UserInfo(
      uId: json['uid'] ?? 0,
      name: json['name'] ?? "",
      username: json['username'] ?? "",
      partnerDisplayName: json['partner_display_name'] ?? "",
      companyId: json['company_id'] ?? 0,
      partnerId: json['partner_id'] ?? 0,
      isAdmin: json['is_admin'] ?? false,
      isSystem: json['is_system'] ?? false,
    );
  }
}

class SignIn {
  String email;
  String password;

  SignIn({this.email = "", this.password = ""});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.toString(),
      'password': password.toString(),
    };
    return map;
  }
}

class AuthResponse {
  bool isAuthSuccessful;
  String token;
  String id;
  String donorCode;
  String errorMessage;

  AuthResponse(
      {this.isAuthSuccessful = false,
      this.token = "",
      this.id = "",
      this.donorCode = "",
      this.errorMessage = ""});

  factory AuthResponse.fromJson(Map<dynamic, dynamic> json) {
    return AuthResponse(
      isAuthSuccessful: json['isAuthSuccessful'] ?? false,
      token: json['token'] ?? "",
      id: json['id'] ?? "",
      donorCode: json['donorCode'] ?? "",
      errorMessage: json['errorMessage'] ?? "",
    );
  }
}

class ChangePasswordModel {
  String currentPassword;
  String newPassword;
  String confirmPassword;
  String donorCode;

  ChangePasswordModel(
      {this.currentPassword = "",
      this.newPassword = "",
      this.confirmPassword = "",
      this.donorCode = ""});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'currentPassword': currentPassword.toString(),
      'newPassword': newPassword.toString(),
      'confirmPassword': confirmPassword.toString(),
      'donorCode': donorCode.toString(),
    };
    return map;
  }
}
