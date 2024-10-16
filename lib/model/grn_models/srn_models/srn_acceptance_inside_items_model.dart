import 'dart:convert';

class SRNAcceptanceItemsInsideModel {
  final double acceptedQty;
  final int poTxnID;
  final String poCode;
  final DateTime poDate;
  final String vendorName;
  final int serviceId;
  final String serviceName;
  final String serviceGroup;
  final String batchNo;
  final String serialNo;
  final int poQty;
  final double poRate;
  final int receivedQty;
  final double receivedRate;
  final int gateEntryID;
  final int vendorID;
  final double taxPercent;
  final double acceptedQtyValue;
  final double acceptedValueTaxAmount;
  final String vendorCurrency;
  final String remarks;

  SRNAcceptanceItemsInsideModel({
    required this.acceptedQty,
    required this.poTxnID,
    required this.poCode,
    required this.poDate,
    required this.vendorName,
    required this.serviceId,
    required this.serviceName,
    required this.serviceGroup,
    required this.batchNo,
    required this.serialNo,
    required this.poQty,
    required this.poRate,
    required this.receivedQty,
    required this.receivedRate,
    required this.gateEntryID,
    required this.vendorID,
    required this.taxPercent,
    required this.acceptedQtyValue,
    required this.acceptedValueTaxAmount,
    required this.vendorCurrency,
    required this.remarks,
  });

  // Factory method for creating an instance from JSON
  factory SRNAcceptanceItemsInsideModel.fromJson(Map<String, dynamic> json) {
    return SRNAcceptanceItemsInsideModel(
      acceptedQty: json['acceptedQty']?.toDouble() ?? 0.0,
      poTxnID: json['POTxnID'] ?? 0,
      poCode: json['POCode'] ?? '',
      poDate: DateTime.parse(json['PODate'] ?? '1970-01-01T00:00:00.000Z'),
      vendorName: json['VendorName'] ?? '',
      serviceId: json['ServiceId'] ?? 0,
      serviceName: json['ServiceName'] ?? '',
      serviceGroup: json['ServiceGroup'] ?? '',
      batchNo: json['BatchNo'] ?? '',
      serialNo: json['SerialNo'] ?? '',
      poQty: json['POQty'] ?? 0,
      poRate: json['PORate']?.toDouble() ?? 0.0,
      receivedQty: json['ReceivedQty'] ?? 0,
      receivedRate: json['ReceivedRate']?.toDouble() ?? 0.0,
      gateEntryID: json['GateEntryID'] ?? 0,
      vendorID: json['VendorID'] ?? 0,
      taxPercent: json['TaxPercent']?.toDouble() ?? 0.0,
      acceptedQtyValue: json['acceptedQtyValue']?.toDouble() ?? 0.0,
      acceptedValueTaxAmount:
          json['accepetedValueTaxAmount']?.toDouble() ?? 0.0,
      vendorCurrency: json['VendorCurrency'] ?? '',
      remarks: json['Remarks'] ?? '',
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'acceptedQty': acceptedQty,
      'POTxnID': poTxnID,
      'POCode': poCode,
      'PODate': poDate.toIso8601String(),
      'VendorName': vendorName,
      'ServiceId': serviceId,
      'ServiceName': serviceName,
      'ServiceGroup': serviceGroup,
      'BatchNo': batchNo,
      'SerialNo': serialNo,
      'POQty': poQty,
      'PORate': poRate,
      'ReceivedQty': receivedQty,
      'ReceivedRate': receivedRate,
      'GateEntryID': gateEntryID,
      'VendorID': vendorID,
      'TaxPercent': taxPercent,
      'acceptedQtyValue': acceptedQtyValue,
      'accepetedValueTaxAmount': acceptedValueTaxAmount,
      'VendorCurrency': vendorCurrency,
      'remarks': remarks,
    };
  }
}
