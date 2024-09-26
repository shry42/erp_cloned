class GetUserDetailsFromPcodemodel {
  final int? userId;
  final String? username;

  GetUserDetailsFromPcodemodel({
    this.userId,
    this.username,
  });

  // Factory method to create an instance from JSON
  factory GetUserDetailsFromPcodemodel.fromJson(Map<String, dynamic> json) {
    return GetUserDetailsFromPcodemodel(
      userId: json['UserID'],
      username: json['Username'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'Username': username,
    };
  }
}
