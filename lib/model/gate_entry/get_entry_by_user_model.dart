class GetEntryByUserModel {
  final int userID;
  final String fullName;
  final String userRole;

  GetEntryByUserModel({
    required this.userID,
    required this.fullName,
    required this.userRole,
  });

  // Factory constructor to create an instance from a JSON map
  factory GetEntryByUserModel.fromJson(Map<String, dynamic> json) {
    return GetEntryByUserModel(
      userID: json['UserID'] as int,
      fullName: json['FullName'] as String,
      userRole: json['UserRole'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'FullName': fullName,
      'UserRole': userRole,
    };
  }
}
