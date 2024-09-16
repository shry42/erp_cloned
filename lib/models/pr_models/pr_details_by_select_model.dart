import 'dart:convert';

class PrDetailsBySelectModel {
  String? itemId;
  String? itemName;
  String? internalCode;
  String? reqQty;
  String? purchaseUOM;
  String? remarks;
  String? hsnCode;
  String? sapId;

  PrDetailsBySelectModel(
      {this.itemId,
      this.itemName,
      this.internalCode,
      this.reqQty,
      this.purchaseUOM,
      this.remarks,
      this.hsnCode,
      this.sapId});

  factory PrDetailsBySelectModel.fromJson(Map<String, dynamic> json) {
    return PrDetailsBySelectModel(
        itemId: json['ItemID'].toString(),
        itemName: json['ItemName'].toString(),
        internalCode: json['InternalCode'].toString(),
        reqQty: json['ReqQty'].toString(),
        purchaseUOM: json['PurchaseUOM'].toString(),
        remarks: json['Remarks'].toString(),
        hsnCode: json['HSN_Code'].toString(),
        sapId: json['SAP_ID'].toString());
  }
}
