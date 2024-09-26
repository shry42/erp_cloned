class GetItemFromItemAndPCodeModel {
  final String? batchNo;
  final String? serialNo;
  final double? unrestrictedStock;
  final String? purchaseUOM;
  final String? inventoryUOM;
  final String? internalCode;
  final int? itemId;
  final int? itemsPerPurchase;
  final String? sapId;

  GetItemFromItemAndPCodeModel({
    this.batchNo,
    this.serialNo,
    this.unrestrictedStock,
    this.purchaseUOM,
    this.inventoryUOM,
    this.internalCode,
    this.itemId,
    this.itemsPerPurchase,
    this.sapId,
  });

  factory GetItemFromItemAndPCodeModel.fromJson(Map<String, dynamic> json) {
    return GetItemFromItemAndPCodeModel(
      batchNo: json['BatchNo'] as String?,
      serialNo: json['SerialNo'] as String?,
      unrestrictedStock: (json['UnrestrictedStock'] as num?)?.toDouble(),
      purchaseUOM: json['PurchaseUOM'] as String?,
      inventoryUOM: json['Inventory_UOM'] as String?,
      internalCode: json['Internal_Code'] as String?,
      itemId: json['ItemID'] as int?,
      itemsPerPurchase: json['Items_per_Purchase'] as int?,
      sapId: json['SAP_ID'] as String?,
    );
  }
}
