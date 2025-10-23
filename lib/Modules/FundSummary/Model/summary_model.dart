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
