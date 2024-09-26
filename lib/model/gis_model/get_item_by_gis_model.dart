class GetItemByGISModel {
  final String? sapId; // SAP ID
  final double? unrestrictedStock; // Unrestricted Stock
  final int? itemId; // Item ID
  final String? internalCode; // Internal Code
  final String? batchNo; // Batch No.
  final String? serialNo; // Serial No.
  final double? reqQty; // Required Quantity
  final double? issuedQty; // Issued Quantity
  final double? diffQty; // Difference Quantity
  final double? balanceQty; // Balance Quantity
  final String? remarks; // Remarks
  final String? purchaseUom; // Purchase UOM

  GetItemByGISModel({
    this.sapId,
    this.unrestrictedStock,
    this.itemId,
    this.internalCode,
    this.batchNo,
    this.serialNo,
    this.reqQty,
    this.issuedQty,
    this.diffQty,
    this.balanceQty,
    this.remarks,
    this.purchaseUom,
  });

  factory GetItemByGISModel.fromJson(Map<String, dynamic> json) {
    return GetItemByGISModel(
      sapId: json['SAP_ID'] as String?,
      unrestrictedStock: (json['UnrestrictedStock'] as num?)?.toDouble(),
      itemId: json['ItemID'] as int?,
      internalCode: json['InternalCode'] as String?,
      batchNo: json['BatchNo'] as String?,
      serialNo: json['SerialNo'] as String?,
      reqQty: (json['ReqQty'] as num?)?.toDouble(),
      issuedQty: (json['IssuedQty'] as num?)?.toDouble(),
      diffQty: (json['DiffQty'] as num?)?.toDouble(),
      balanceQty: (json['BalanceQty'] as num?)?.toDouble(),
      remarks: json['Remarks'] as String?,
      purchaseUom: json['Purchase_UOM'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SAP_ID': sapId,
      'UnrestrictedStock': unrestrictedStock,
      'ItemID': itemId,
      'InternalCode': internalCode,
      'BatchNo': batchNo,
      'SerialNo': serialNo,
      'ReqQty': reqQty,
      'IssuedQty': issuedQty,
      'DiffQty': diffQty,
      'BalanceQty': balanceQty,
      'Remarks': remarks,
      'Purchase_UOM': purchaseUom,
    };
  }
}
