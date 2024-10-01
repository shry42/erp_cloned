class RDStockListModel {
  int? itemID;
  String? itemName;
  String? batchNo;
  String? serialNo;
  String? internalCode;
  String? itemGroup;
  String? purchaseUOM;
  double? unrestrictedStock;
  double? qaStock;
  double? blockedStock;

  RDStockListModel({
    this.itemID,
    this.itemName,
    this.batchNo,
    this.serialNo,
    this.internalCode,
    this.itemGroup,
    this.purchaseUOM,
    this.unrestrictedStock,
    this.qaStock,
    this.blockedStock,
  });

  // fromJson method to parse JSON data
  factory RDStockListModel.fromJson(Map<String, dynamic> json) {
    return RDStockListModel(
      itemID: json['ItemID'] as int?,
      itemName: json['ItemName'] as String?,
      batchNo: json['BatchNo'] as String?,
      serialNo: json['SerialNo'] as String?,
      internalCode: json['InternalCode'] as String?,
      itemGroup: json['ItemGroup'] as String?,
      purchaseUOM: json['PurchaseUOM'] as String?,
      unrestrictedStock: (json['UnrestrictedStock'] as num?)?.toDouble(),
      qaStock: (json['QAStock'] as num?)?.toDouble(),
      blockedStock: (json['BlockedStock'] as num?)?.toDouble(),
    );
  }

  // Optional toJson method to convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemID,
      'ItemName': itemName,
      'BatchNo': batchNo,
      'SerialNo': serialNo,
      'InternalCode': internalCode,
      'ItemGroup': itemGroup,
      'PurchaseUOM': purchaseUOM,
      'UnrestrictedStock': unrestrictedStock,
      'QAStock': qaStock,
      'BlockedStock': blockedStock,
    };
  }
}
