class GetItemDetailsByPRTxnIDModel {
  final String? itemName;
  final int? itemID;
  final String? internalCode;
  final int? requestedQty;
  final String? purchaseUOM;
  final String? itemGroup;
  final String? sapID;
  final String? remarks;
  final int? remainingQty;

  GetItemDetailsByPRTxnIDModel({
    this.itemName,
    this.itemID,
    this.internalCode,
    this.requestedQty,
    this.purchaseUOM,
    this.itemGroup,
    this.sapID,
    this.remarks,
    this.remainingQty,
  });

  factory GetItemDetailsByPRTxnIDModel.fromJson(Map<String, dynamic> json) {
    return GetItemDetailsByPRTxnIDModel(
      itemName: json['ItemName'],
      itemID: json['ItemID'],
      internalCode: json['InternalCode'],
      requestedQty: json['RequestedQty'],
      purchaseUOM: json['PurchaseUOM'],
      itemGroup: json['Item_Group'],
      sapID: json['SAP_ID'],
      remarks: json['Remarks'],
      remainingQty: json['RemainingQty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ItemName': itemName,
      'ItemID': itemID,
      'InternalCode': internalCode,
      'RequestedQty': requestedQty,
      'PurchaseUOM': purchaseUOM,
      'Item_Group': itemGroup,
      'SAP_ID': sapID,
      'Remarks': remarks,
      'RemainingQty': remainingQty,
    };
  }
}
