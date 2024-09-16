class UserMenuModel {
  int? userID;
  String? username;

  UserMenuModel({this.userID, this.username});

  // Factory constructor for creating a new UserMenuModel instance from a map
  factory UserMenuModel.fromJson(Map<String, dynamic> json) {
    return UserMenuModel(
      userID: json['UserID'] as int?,
      username: json['Username'] as String?,
    );
  }

  // Method to convert UserMenuModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'Username': username,
    };
  }
}
