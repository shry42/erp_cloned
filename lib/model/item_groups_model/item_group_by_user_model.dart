class GetItemGroupByUserModel {
  int? userId;
  String? itemGroup;
  DateTime? addedOn;

  GetItemGroupByUserModel({
    this.userId,
    this.itemGroup,
    this.addedOn,
  });

  // Factory constructor to create an instance from a JSON map
  factory GetItemGroupByUserModel.fromJson(Map<String, dynamic> json) {
    return GetItemGroupByUserModel(
      userId: json['UserID'],
      itemGroup: json['ItemGroup'],
      addedOn: json['AddedOn'] != null ? DateTime.parse(json['AddedOn']) : null,
    );
  }

  // Method to convert the model instance back to JSON map
  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'ItemGroup': itemGroup,
      'AddedOn': addedOn?.toIso8601String(),
    };
  }
}
