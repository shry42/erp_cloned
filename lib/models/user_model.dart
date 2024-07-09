import 'dart:convert';

class User {
  int id;
  final String? username;
  final String? fullName;
  final String? mobileNumber;
  final String? emailId;
  final String? department;
  final String? userRole;
  DateTime createdOn;
  bool resetFlag;
  // DateTime lastPasswordUpdate;
  DateTime lastLogin;
  final int? loginAttempts;
  final int? isActive;
  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.mobileNumber,
    required this.emailId,
    required this.department,
    required this.userRole,
    required this.createdOn,
    required this.resetFlag,
    // required this.lastPasswordUpdate,
    required this.lastLogin,
    required this.loginAttempts,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["UserID"],
        username: json["Username"],
        fullName: json["FullName"],
        mobileNumber: json["MobileNumber"],
        emailId: json["EmailID"],
        department: json["Department"],
        userRole: json["UserRole"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        resetFlag: json["ResetFlag"],
        // lastPasswordUpdate: DateTime.parse(json["LastPasswordUpdate"]),
        lastLogin: DateTime.parse(json["LastLogin"]),
        loginAttempts: json["LoginAttempts"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": id,
        "Username": username,
        "FullName": fullName,
        "MobileNumber": mobileNumber,
        "EmailID": emailId,
        "Department": department,
        "UserRole": userRole,
        "CreatedOn": createdOn.toIso8601String(),
        "ResetFlag": resetFlag,
        // "LastPasswordUpdate": lastPasswordUpdate.toIso8601String(),
        "LastLogin": lastLogin.toIso8601String(),
        "LoginAttempts": loginAttempts,
        "isActive": isActive,
      };
}
