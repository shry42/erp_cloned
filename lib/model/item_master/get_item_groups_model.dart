class GetItemsGroupModel {
  final int? igId;
  final String? itemGroups;
  final String? createdOn;
  final String? itemType;
  final String? prefix;
  final String? suffix;

  GetItemsGroupModel({
    this.igId,
    this.itemGroups,
    this.createdOn,
    this.itemType,
    this.prefix,
    this.suffix,
  });

  factory GetItemsGroupModel.fromJson(Map<String, dynamic> json) {
    return GetItemsGroupModel(
      igId: json['IG_ID'] as int?,
      itemGroups: json['Item_Groups'] as String?,
      createdOn: json['Created_On'] as String?,
      itemType: json['itemType'] as String?,
      prefix: json['Prefix'] as String?,
      suffix: json['Suffix'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IG_ID': igId,
      'Item_Groups': itemGroups,
      'Created_On': createdOn,
      'itemType': itemType,
      'Prefix': prefix,
      'Suffix': suffix,
    };
  }
}
