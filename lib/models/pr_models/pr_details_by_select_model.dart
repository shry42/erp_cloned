import 'dart:convert';

class PrDetailsBySelectModel {
  String? itemId;
  String? itemName;
  String? internalCode;
  double? reqQty; // Changed to double to handle numeric values
  String? purchaseUOM;
  String? remarks;
  String? itemGroup; // Added field for Item_Group
  String? hsnCode;
  String? sapId;
  double? poQty; // Added field for POQty as a double
  double? openQty; // Added field for OpenQty as a double

  PrDetailsBySelectModel({
    this.itemId,
    this.itemName,
    this.internalCode,
    this.reqQty,
    this.purchaseUOM,
    this.remarks,
    this.itemGroup,
    this.hsnCode,
    this.sapId,
    this.poQty,
    this.openQty,
  });

  factory PrDetailsBySelectModel.fromJson(Map<String, dynamic> json) {
    return PrDetailsBySelectModel(
      itemId: json['ItemID'].toString(),
      itemName: json['ItemName'].toString(),
      internalCode: json['InternalCode'].toString(),
      reqQty: (json['ReqQty'] as num?)?.toDouble(), // Convert to double
      purchaseUOM: json['PurchaseUOM'].toString(),
      remarks: json['Remarks'].toString(),
      itemGroup: json['Item_Group'].toString(), // Added Item_Group
      hsnCode: json['HSN_Code'].toString(),
      sapId: json['SAP_ID'].toString(),
      poQty: (json['POQty'] as num?)?.toDouble(), // Convert to double
      openQty: (json['OpenQty'] as num?)?.toDouble(), // Convert to double
    );
  }

  Map<String, dynamic> toJson() => {
        "ItemID": itemId,
        "ItemName": itemName,
        "InternalCode": internalCode,
        "ReqQty": reqQty,
        "PurchaseUOM": purchaseUOM,
        "Remarks": remarks,
        "Item_Group": itemGroup,
        "HSN_Code": hsnCode,
        "SAP_ID": sapId,
        "POQty": poQty,
        "OpenQty": openQty,
      };
}
