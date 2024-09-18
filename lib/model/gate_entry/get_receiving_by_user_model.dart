class GetReceivingByUserModel {
  final int userID;
  final String fullName;

  GetReceivingByUserModel({
    required this.userID,
    required this.fullName,
  });

  // Factory constructor to create an instance from a JSON map
  factory GetReceivingByUserModel.fromJson(Map<String, dynamic> json) {
    return GetReceivingByUserModel(
      userID: json['UserID'] as int,
      fullName: json['FullName'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'FullName': fullName,
    };
  }
}
