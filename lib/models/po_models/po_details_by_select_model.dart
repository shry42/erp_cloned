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
  String ItemGroup; // Now a String for Item_Group
  String PRTxnID; // Now a String for PRTxnID
  String ReqQty; // Now a String for ReqQty
  String RemainingQty; // Now a String for RemainingQty

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
    required this.ItemGroup, // Now a String
    required this.PRTxnID, // Now a String
    required this.ReqQty, // Now a String
    required this.RemainingQty, // Now a String
  });

  factory PoDetailsBySelectIdModel.fromJson(Map<String, dynamic> json) =>
      PoDetailsBySelectIdModel(
        PODetailsID: json["PODetailsID"].toString(),
        POTxnID: json["POTxnID"].toString(),
        ItemID: json["ItemID"].toString(),
        SAPID: json["SAPID"].toString(),
        ItemName: json["ItemName"].toString(),
        HSN_Code: json["HSN_Code"].toString(),
        POQty: json["POQty"].toString(),
        PurchaseUOM: json["PurchaseUOM"].toString(),
        DeliveryDate: json["DeliveryDate"].toString(),
        UnitPrice: json["UnitPrice"].toString(),
        TaxCode: json["TaxCode"].toString(),
        TaxPercent: json["TaxPercent"].toString(),
        LineTotal: json["LineTotal"].toString(),
        TaxAmt: json["TaxAmt"].toString(),
        FinalAmt: json["FinalAmt"].toString(),
        RevisionNumber: json["RevisionNumber"].toString(),
        BuyerName: json["BuyerName"].toString(),
        BuyerEmailID: json["BuyerEmailID"].toString(),
        BuyerTel: json["BuyerTel"].toString(),
        BuyerMob: json["BuyerMob"].toString(),
        SupplierPOCName: json["SupplierPOCName"].toString(),
        QuoteDate: json["QuoteDate"].toString(),
        ItemGroup: json["Item_Group"].toString(), // Now a String
        PRTxnID: json["PRTxnID"].toString(), // Now a String
        ReqQty: json["ReqQty"].toString(), // Now a String
        RemainingQty: json["RemainingQty"].toString(), // Now a String
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
        "Item_Group": ItemGroup, // Now a String
        "PRTxnID": PRTxnID, // Now a String
        "ReqQty": ReqQty, // Now a String
        "RemainingQty": RemainingQty, // Now a String
      };
}
