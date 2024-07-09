class PoLogModel {
  String POTxnID;
  String POCode;
  String PODate;
  String PRTxnID;
  String VendorID;
  String SupplierQuoteNo;
  String QuoteDate;
  String BuyerName;
  String BuyerEmailID;
  String BuyerTel;
  String BuyerMob;
  String SupplierPOCName;
  String SupplierPOCEmailID;
  String SupplierPOCTel;
  String SupplierPOCMob;
  String DeliveryTerms;
  String PaymentTerms;
  String HeaderNote;
  String ApprovalStatus;
  String POFulfillmentLevel;
  String POStatus;
  String RevisionNumber;
  String FinancialYear;
  String ApprovedON;
  String ApprovedBy;

  PoLogModel(
      {required this.POTxnID,
      required this.POCode,
      required this.PODate,
      required this.PRTxnID,
      required this.VendorID,
      required this.SupplierQuoteNo,
      required this.QuoteDate,
      required this.BuyerName,
      required this.BuyerEmailID,
      required this.BuyerTel,
      required this.BuyerMob,
      required this.SupplierPOCName,
      required this.SupplierPOCEmailID,
      required this.SupplierPOCTel,
      required this.SupplierPOCMob,
      required this.DeliveryTerms,
      required this.PaymentTerms,
      required this.HeaderNote,
      required this.ApprovalStatus,
      required this.POFulfillmentLevel,
      required this.POStatus,
      required this.RevisionNumber,
      required this.FinancialYear,
      required this.ApprovedON,
      required this.ApprovedBy});

  factory PoLogModel.fromJson(Map<String, dynamic> json) {
    return PoLogModel(
      POTxnID: json['POTxnID'].toString(),
      POCode: json['POCode'].toString(),
      PODate: json['PODate'].toString(),
      PRTxnID: json['PRTxnID'].toString(),
      VendorID: json['VendorID'].toString(),
      SupplierQuoteNo: json['SupplierQuoteNo'].toString(),
      QuoteDate: json['QuoteDate'].toString(),
      BuyerName: json['BuyerName'].toString(),
      BuyerEmailID: json['BuyerEmailID'].toString(),
      BuyerTel: json['BuyerTel'].toString(),
      BuyerMob: json['BuyerMob'].toString(),
      SupplierPOCName: json['SupplierPOCName'].toString(),
      SupplierPOCEmailID: json['SupplierPOCEmailID'].toString(),
      SupplierPOCTel: json['SupplierPOCTel'].toString(),
      SupplierPOCMob: json['SupplierPOCMob'].toString(),
      DeliveryTerms: json['DeliveryTerms'].toString(),
      PaymentTerms: json['PaymentTerms'].toString(),
      HeaderNote: json['HeaderNote'].toString(),
      ApprovalStatus: json['ApprovalStatus'].toString(),
      POFulfillmentLevel: json['POFulfillmentLevel'].toString(),
      POStatus: json['POStatus'].toString().toString(),
      RevisionNumber: json['RevisionNumber'].toString(),
      FinancialYear: json['FinancialYear'].toString(),
      ApprovedON: json['ApprovedON'].toString(),
      ApprovedBy: json['ApprovedBy'].toString(),
    );
  }
}
