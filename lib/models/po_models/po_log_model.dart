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
  bool ApprovalStatus;
  int POFulfillmentLevel;
  String POStatus;
  int RevisionNumber;
  String FinancialYear;
  String ApprovedON;
  int ApprovedBy;
  String? cancelReason;
  String? generatedAt;
  String? createdBy;
  String Department;
  int PODetailsCount;
  int POServiceDetailsCount;

  PoLogModel({
    required this.POTxnID,
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
    required this.ApprovedBy,
    this.cancelReason,
    this.generatedAt,
    this.createdBy,
    required this.Department,
    required this.PODetailsCount,
    required this.POServiceDetailsCount,
  });

  factory PoLogModel.fromJson(Map<String, dynamic> json) {
    return PoLogModel(
      POTxnID: json['POTxnID'].toString(),
      POCode: json['POCode'].toString(),
      PODate: json['PODate'].toString(),
      PRTxnID: json['PRTxnID'].toString(),
      VendorID: json['VendorID'].toString(),
      SupplierQuoteNo: json['SupplierQuoteNo']?.toString() ?? '',
      QuoteDate: json['QuoteDate'].toString(),
      BuyerName: json['BuyerName'].toString(),
      BuyerEmailID: json['BuyerEmailID'].toString(),
      BuyerTel: json['BuyerTel'].toString(),
      BuyerMob: json['BuyerMob'].toString(),
      SupplierPOCName: json['SupplierPOCName']?.toString() ?? '',
      SupplierPOCEmailID: json['SupplierPOCEmailID'].toString(),
      SupplierPOCTel: json['SupplierPOCTel'].toString(),
      SupplierPOCMob: json['SupplierPOCMob'].toString(),
      DeliveryTerms: json['DeliveryTerms'].toString(),
      PaymentTerms: json['PaymentTerms'].toString(),
      HeaderNote: json['HeaderNote']?.toString() ?? '',
      ApprovalStatus: json['ApprovalStatus'] ?? false,
      POFulfillmentLevel: json['POFulfillmentLevel'] ?? 0,
      POStatus: json['POStatus'].toString(),
      RevisionNumber: json['RevisionNumber'] ?? 0,
      FinancialYear: json['FinancialYear'].toString(),
      ApprovedON: json['ApprovedON'].toString(),
      ApprovedBy: json['ApprovedBy'] ?? 0,
      cancelReason: json['cancelReason']?.toString(),
      generatedAt: json['generatedAt']?.toString(),
      createdBy: json['createdBy']?.toString(),
      Department: json['Department'].toString(),
      PODetailsCount: json['PODetailsCount'] ?? 0,
      POServiceDetailsCount: json['POServiceDetailsCount'] ?? 0,
    );
  }
}
