import 'dart:convert';

class PoDetailsBySelectIdModel {
  String PODetailsID;
  String POTxnID;
  String ItemID;
  String SAPID;
  String ItemName;
  String HSN_Code;
  String POQty;
  String PurchaseUOM;
  String DeliveryDate;
  String UnitPrice;
  String TaxCode;
  String TaxPercent;
  String LineTotal;
  String TaxAmt;
  String FinalAmt;
  String RevisionNumber;
  String BuyerName;
  String BuyerEmailID;
  String BuyerTel;
  String BuyerMob;
  String SupplierPOCName;
  String QuoteDate;

  PoDetailsBySelectIdModel({
    required this.PODetailsID,
    required this.POTxnID,
    required this.ItemID,
    required this.SAPID,
    required this.ItemName,
    required this.HSN_Code,
    required this.POQty,
    required this.PurchaseUOM,
    required this.DeliveryDate,
    required this.UnitPrice,
    required this.TaxCode,
    required this.TaxPercent,
    required this.LineTotal,
    required this.TaxAmt,
    required this.FinalAmt,
    required this.RevisionNumber,
    required this.BuyerName,
    required this.BuyerEmailID,
    required this.BuyerTel,
    required this.BuyerMob,
    required this.SupplierPOCName,
    required this.QuoteDate,
  });

  factory PoDetailsBySelectIdModel.fromJson(Map<String, dynamic> json) =>
      PoDetailsBySelectIdModel(
        PODetailsID: json["PODetailsID"].toString(),
        POTxnID: json["POTxnID"].toString(),
        ItemID: json["ItemID"].toString(),
        SAPID: json["SAPID"].toString(),
        ItemName: json["ItemName"],
        HSN_Code: json["HSN_Code"],
        POQty: json["POQty"].toString(),
        PurchaseUOM: json["PurchaseUOM"],
        DeliveryDate: json["DeliveryDate"].toString(),
        UnitPrice: json["UnitPrice"].toString(),
        TaxCode: json["TaxCode"],
        TaxPercent: json["TaxPercent"].toString(),
        LineTotal: json["LineTotal"].toString(),
        TaxAmt: json["TaxAmt"].toString(),
        FinalAmt: json["FinalAmt"].toString(),
        RevisionNumber: json["RevisionNumber"].toString(),
        BuyerName: json["BuyerName"],
        BuyerEmailID: json["BuyerEmailID"],
        BuyerTel: json["BuyerTel"],
        BuyerMob: json["BuyerMob"],
        SupplierPOCName: json["SupplierPOCName"],
        QuoteDate: json["QuoteDate"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "PODetailsID": PODetailsID,
        "POTxnID": POTxnID,
        "ItemID": ItemID,
        "SAPID": SAPID,
        "ItemName": ItemName,
        "HSN_Code": HSN_Code,
        "POQty": POQty,
        "PurchaseUOM": PurchaseUOM,
        "DeliveryDate": DeliveryDate,
        "UnitPrice": UnitPrice,
        "TaxCode": TaxCode,
        "TaxPercent": TaxPercent,
        "LineTotal": LineTotal,
        "TaxAmt": TaxAmt,
        "FinalAmt": FinalAmt,
        "RevisionNumber": RevisionNumber,
        "BuyerName": BuyerName,
        "BuyerEmailID": BuyerEmailID,
        "BuyerTel": BuyerTel,
        "BuyerMob": BuyerMob,
        "SupplierPOCName": SupplierPOCName,
        "QuoteDate": QuoteDate,
      };
}
