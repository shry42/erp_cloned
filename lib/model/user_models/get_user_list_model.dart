class UsersListModel {
  final int? userID;
  final String? username;
  final String? fullName;
  final String? mobileNumber;
  final String? emailID;
  final String? department;
  final String? userRole;
  final int? isActive;
  final DateTime? createdOn;
  final String? empCode;

  UsersListModel({
    this.userID,
    this.username,
    this.fullName,
    this.mobileNumber,
    this.emailID,
    this.department,
    this.userRole,
    this.isActive,
    this.createdOn,
    this.empCode,
  });

  factory UsersListModel.fromJson(Map<String, dynamic> json) {
    return UsersListModel(
      userID: json['UserID'] as int?,
      username: json['Username'] as String?,
      fullName: json['FullName'] as String?,
      mobileNumber: json['MobileNumber'] as String?,
      emailID: json['EmailID'] as String?,
      department: json['Department'] as String?,
      userRole: json['UserRole'] as String?,
      isActive: json['isActive'] as int?,
      createdOn:
          json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn']) : null,
      empCode: json['empCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'Username': username,
      'FullName': fullName,
      'MobileNumber': mobileNumber,
      'EmailID': emailID,
      'Department': department,
      'UserRole': userRole,
      'isActive': isActive,
      'CreatedOn': createdOn?.toIso8601String(),
      'empCode': empCode,
    };
  }
}
