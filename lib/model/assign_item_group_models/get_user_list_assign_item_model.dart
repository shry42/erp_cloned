class GetAssignItemsUserListModel {
  final int? userId;
  final String? username;

  GetAssignItemsUserListModel({this.userId, this.username});

  factory GetAssignItemsUserListModel.fromJson(Map<String, dynamic> json) {
    return GetAssignItemsUserListModel(
      userId: json['UserID'] as int?,
      username: json['Username'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'Username': username,
    };
  }
}
