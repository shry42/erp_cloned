class ItemMasterListModel {
  int? itemID;
  String? internalCode;
  String? purchaseUOM;
  String? itemName;
  String? sapID;

  ItemMasterListModel({
    this.itemID,
    this.internalCode,
    this.purchaseUOM,
    this.itemName,
    this.sapID,
  });

  factory ItemMasterListModel.fromJson(Map<String, dynamic> json) {
    return ItemMasterListModel(
      itemID: json['ItemID'] as int?,
      internalCode: json['Internal_Code'] as String?,
      purchaseUOM: json['Purchase_UOM'] as String?,
      itemName: json['Item_Name'] as String?,
      sapID: json['SAP_ID'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemID,
      'Internal_Code': internalCode,
      'Purchase_UOM': purchaseUOM,
      'Item_Name': itemName,
      'SAP_ID': sapID,
    };
  }
}
