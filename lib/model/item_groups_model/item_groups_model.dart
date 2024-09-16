class ItemGroupModel {
  final int? igId;
  final String? itemGroups;
  final DateTime? createdOn;
  final String? itemType;
  final int? prefix;
  final int? suffix;

  ItemGroupModel({
    this.igId,
    this.itemGroups,
    this.createdOn,
    this.itemType,
    this.prefix,
    this.suffix,
  });

  factory ItemGroupModel.fromJson(Map<String, dynamic> json) {
    return ItemGroupModel(
      igId: json['IG_ID'] as int?,
      itemGroups: json['Item_Groups'] as String?,
      createdOn: json['Created_On'] != null
          ? DateTime.parse(json['Created_On'])
          : null,
      itemType: json['itemType'] as String?,
      prefix: json['Prefix'] != null ? json['Prefix'] as int : null,
      suffix: json['Suffix'] != null ? json['Suffix'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IG_ID': igId,
      'Item_Groups': itemGroups,
      'Created_On': createdOn?.toIso8601String(),
      'itemType': itemType,
      'Prefix': prefix,
      'Suffix': suffix,
    };
  }
}
