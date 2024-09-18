class GetPOLogByVendorIdModel {
  int? poTxnID;
  String? poCode;
  DateTime? poDate;
  int? prTxnID;
  int? vendorID;
  String? supplierQuoteNo;
  DateTime? quoteDate;
  String? buyerName;
  String? buyerEmailID;
  String? buyerTel;
  String? buyerMob;
  String? supplierPOCName;
  String? supplierPOCEmailID;
  String? supplierPOCTel;
  String? supplierPOCMob;
  String? deliveryTerms;
  String? paymentTerms;
  String? headerNote;
  bool? approvalStatus;
  int? poFulfillmentLevel;
  String? poStatus;
  int? revisionNumber;
  String? financialYear;
  DateTime? approvedOn;
  String? approvedBy;
  String? cancelReason;
  DateTime? generatedAt;
  String? createdBy;

  GetPOLogByVendorIdModel({
    this.poTxnID,
    this.poCode,
    this.poDate,
    this.prTxnID,
    this.vendorID,
    this.supplierQuoteNo,
    this.quoteDate,
    this.buyerName,
    this.buyerEmailID,
    this.buyerTel,
    this.buyerMob,
    this.supplierPOCName,
    this.supplierPOCEmailID,
    this.supplierPOCTel,
    this.supplierPOCMob,
    this.deliveryTerms,
    this.paymentTerms,
    this.headerNote,
    this.approvalStatus,
    this.poFulfillmentLevel,
    this.poStatus,
    this.revisionNumber,
    this.financialYear,
    this.approvedOn,
    this.approvedBy,
    this.cancelReason,
    this.generatedAt,
    this.createdBy,
  });

  factory GetPOLogByVendorIdModel.fromJson(Map<String, dynamic> json) {
    return GetPOLogByVendorIdModel(
      poTxnID: json['POTxnID'] as int?,
      poCode: _parseString(json['POCode']),
      poDate: _parseDate(json['PODate']),
      prTxnID: json['PRTxnID'] as int?,
      vendorID: json['VendorID'] as int?,
      supplierQuoteNo: _parseString(json['SupplierQuoteNo']),
      quoteDate: _parseDate(json['QuoteDate']),
      buyerName: _parseString(json['BuyerName']),
      buyerEmailID: _parseString(json['BuyerEmailID']),
      buyerTel: _parseString(json['BuyerTel']),
      buyerMob: _parseString(json['BuyerMob']),
      supplierPOCName: _parseString(json['SupplierPOCName']),
      supplierPOCEmailID: _parseString(json['SupplierPOCEmailID']),
      supplierPOCTel: _parseString(json['SupplierPOCTel']),
      supplierPOCMob: _parseString(json['SupplierPOCMob']),
      deliveryTerms: _parseString(json['DeliveryTerms']),
      paymentTerms: _parseString(json['PaymentTerms']),
      headerNote: _parseString(json['HeaderNote']),
      approvalStatus: json['ApprovalStatus'] as bool?,
      poFulfillmentLevel: json['POFulfillmentLevel'] as int?,
      poStatus: _parseString(json['POStatus']),
      revisionNumber: json['RevisionNumber'] as int?,
      financialYear: _parseString(json['FinancialYear']),
      approvedOn: _parseDate(json['ApprovedON']),
      approvedBy: _parseString(json['ApprovedBy']),
      cancelReason: _parseString(json['cancelReason']),
      generatedAt: _parseDate(json['generatedAt']),
      createdBy: _parseString(json['createdBy']),
    );
  }

// Helper method to handle empty strings and nulls
  static String? _parseString(dynamic value) {
    return value != null && value is String && value.isNotEmpty ? value : null;
  }

// Helper method to handle date parsing
  static DateTime? _parseDate(dynamic value) {
    if (value == null || value is! String || value.isEmpty) {
      return null;
    }
    try {
      return DateTime.tryParse(value);
    } catch (e) {
      print('Date parsing error: $e');
      return null;
    }
  }
}
