import 'dart:convert';

class GetPOItemsModel {
  String? itemGroup;
  int? poTxnID;
  int? itemID;
  String? itemName;
  int? poQty;
  double? unitPrice;
  String? purchaseUOM;
  String? sapID;
  String? hsnCode;
  DateTime? deliveryDate;
  String? taxCode;
  double? taxPercent;
  double? lineTotal;
  double? taxAmt;
  double? finalAmt;
  int? totalReceivedQty;
  int? acceptedQty;
  int? remainingQty;

  GetPOItemsModel({
    this.itemGroup,
    this.poTxnID,
    this.itemID,
    this.itemName,
    this.poQty,
    this.unitPrice,
    this.purchaseUOM,
    this.sapID,
    this.hsnCode,
    this.deliveryDate,
    this.taxCode,
    this.taxPercent,
    this.lineTotal,
    this.taxAmt,
    this.finalAmt,
    this.totalReceivedQty,
    this.acceptedQty,
    this.remainingQty,
  });

  factory GetPOItemsModel.fromJson(Map<String, dynamic> json) {
    return GetPOItemsModel(
      itemGroup:
          json['Item_Group'] != "" ? json['Item_Group'] as String? : null,
      poTxnID: json['POTxnID'] as int?,
      itemID: json['ItemID'] as int?,
      itemName: json['ItemName'] != "" ? json['ItemName'] as String? : null,
      poQty: json['POQty'] as int?,
      unitPrice: json['UnitPrice']?.toDouble(), // Ensure it's a double
      purchaseUOM:
          json['PurchaseUOM'] != "" ? json['PurchaseUOM'] as String? : null,
      sapID: json['SAPID'] != "" ? json['SAPID'] as String? : null,
      hsnCode: json['HSN_Code'] != "" ? json['HSN_Code'] as String? : null,
      deliveryDate: json['DeliveryDate'] != null && json['DeliveryDate'] != ""
          ? DateTime.tryParse(json['DeliveryDate'])
          : null,
      taxCode: json['TaxCode'] != "" ? json['TaxCode'] as String? : null,
      taxPercent: json['TaxPercent']?.toDouble(), // Ensure it's a double
      lineTotal: json['LineTotal']?.toDouble(), // Ensure it's a double
      taxAmt: json['TaxAmt']?.toDouble(), // Ensure it's a double
      finalAmt: json['FinalAmt']?.toDouble(), // Ensure it's a double
      totalReceivedQty: json['TotalReceivedQty'] as int?,
      acceptedQty: json['acceptedQty'] as int?,
      remainingQty: json['RemainingQty'] as int?,
    );
  }

  // Optionally, you can add a method to convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'Item_Group': itemGroup,
      'POTxnID': poTxnID,
      'ItemID': itemID,
      'ItemName': itemName,
      'POQty': poQty,
      'UnitPrice': unitPrice,
      'PurchaseUOM': purchaseUOM,
      'SAPID': sapID,
      'HSN_Code': hsnCode,
      'DeliveryDate': deliveryDate?.toIso8601String(),
      'TaxCode': taxCode,
      'TaxPercent': taxPercent,
      'LineTotal': lineTotal,
      'TaxAmt': taxAmt,
      'FinalAmt': finalAmt,
      'TotalReceivedQty': totalReceivedQty,
      'acceptedQty': acceptedQty,
      'RemainingQty': remainingQty,
    };
  }
}
