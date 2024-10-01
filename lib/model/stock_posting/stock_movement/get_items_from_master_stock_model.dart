class GetItemsFromMasterStockModel {
  int? itemID;
  String? itemName;
  String? purchaseUOM;
  String? inventoryUOM;
  String? internalCode;

  GetItemsFromMasterStockModel({
    this.itemID,
    this.itemName,
    this.purchaseUOM,
    this.inventoryUOM,
    this.internalCode,
  });

  // fromJson method to parse JSON data
  factory GetItemsFromMasterStockModel.fromJson(Map<String, dynamic> json) {
    return GetItemsFromMasterStockModel(
      itemID: json['ItemID'] as int?,
      itemName: json['Item_Name'] as String?,
      purchaseUOM: json['Purchase_UOM'] as String?,
      inventoryUOM: json['Inventory_UOM'] as String?,
      internalCode: json['Internal_Code'] as String?,
    );
  }

  // toJson method to convert model to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemID,
      'Item_Name': itemName,
      'Purchase_UOM': purchaseUOM,
      'Inventory_UOM': inventoryUOM,
      'Internal_Code': internalCode,
    };
  }
}
