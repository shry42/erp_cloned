import 'dart:convert';

class GetApprovedPoModel {
  final int? poTxnID;
  final String? poCode;
  final DateTime? poDate;
  final int? vendorID;
  final int? revisionNumber;
  final String? buyerName;
  final String? buyerEmailID;
  final String? buyerTel;
  final String? buyerMob;
  final String? supplierPOCName;
  final String? headerNote;
  final String? deliveryTerms;
  final String? paymentTerms;
  final DateTime? quoteDate;

  GetApprovedPoModel({
    this.poTxnID,
    this.poCode,
    this.poDate,
    this.vendorID,
    this.revisionNumber,
    this.buyerName,
    this.buyerEmailID,
    this.buyerTel,
    this.buyerMob,
    this.supplierPOCName,
    this.headerNote,
    this.deliveryTerms,
    this.paymentTerms,
    this.quoteDate,
  });

  factory GetApprovedPoModel.fromJson(Map<String, dynamic> json) {
    return GetApprovedPoModel(
      poTxnID: json['POTxnID'] as int?,
      poCode: json['POCode'] as String?,
      poDate: json['PODate'] != null
          ? DateTime.parse(json['PODate'] as String)
          : null,
      vendorID: json['VendorID'] as int?,
      revisionNumber: json['RevisionNumber'] as int?,
      buyerName: json['BuyerName'] as String?,
      buyerEmailID: json['BuyerEmailID'] as String?,
      buyerTel: json['BuyerTel'] as String?,
      buyerMob: json['BuyerMob'] as String?,
      supplierPOCName: json['SupplierPOCName'] as String?,
      headerNote: json['HeaderNote'] as String?,
      deliveryTerms: json['DeliveryTerms'] as String?,
      paymentTerms: json['PaymentTerms'] as String?,
      quoteDate: json['QuoteDate'] != null
          ? DateTime.parse(json['QuoteDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'POTxnID': poTxnID,
      'POCode': poCode,
      'PODate': poDate?.toIso8601String(),
      'VendorID': vendorID,
      'RevisionNumber': revisionNumber,
      'BuyerName': buyerName,
      'BuyerEmailID': buyerEmailID,
      'BuyerTel': buyerTel,
      'BuyerMob': buyerMob,
      'SupplierPOCName': supplierPOCName,
      'HeaderNote': headerNote,
      'DeliveryTerms': deliveryTerms,
      'PaymentTerms': paymentTerms,
      'QuoteDate': quoteDate?.toIso8601String(),
    };
  }
}
