class GetUserItemsGroupsModel {
  String? itemType;
  String? itemGroups;
  DateTime? createdOn;
  int? igId;
  String? prefix;
  String? suffix;

  GetUserItemsGroupsModel({
    this.itemType,
    this.itemGroups,
    this.createdOn,
    this.igId,
    this.prefix,
    this.suffix,
  });

  // Factory method to create a GetUserItemsGroupsModel from JSON
  factory GetUserItemsGroupsModel.fromJson(Map<String, dynamic> json) {
    return GetUserItemsGroupsModel(
      itemType:
          json['itemType']?.toString(), // Convert int to String if necessary
      itemGroups:
          json['Item_Groups']?.toString(), // Convert int to String if necessary
      createdOn: json['Created_On'] != null
          ? DateTime.tryParse(
              json['Created_On'] as String) // Safely parse the date
          : null,
      igId: json['IG_ID'] as int?, // Can be null
      prefix: json['Prefix']?.toString(), // Convert int to String if necessary
      suffix: json['Suffix']?.toString(), // Convert int to String if necessary
    );
  }

  // Method to convert the model to JSON (handling null values)
  Map<String, dynamic> toJson() {
    return {
      'itemType': itemType,
      'Item_Groups': itemGroups,
      'Created_On': createdOn?.toIso8601String(), // Convert date if not null
      'IG_ID': igId,
      'Prefix': prefix,
      'Suffix': suffix,
    };
  }
}
