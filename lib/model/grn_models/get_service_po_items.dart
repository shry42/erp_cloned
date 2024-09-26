class GetServicePOItemsModel {
  int? poTxnID;
  int? serviceId;
  String? serviceName;
  String? serviceGroup;
  double? poQty;
  double? unitPrice;
  String? purchaseUOM;
  String? sacCode;
  DateTime? deliveryDate;
  String? taxCode;
  double? taxPercent;
  double? lineTotal;
  double? taxAmt;
  double? finalAmt;
  double? totalReceivedQty;
  double? remainingQty;

  GetServicePOItemsModel({
    this.poTxnID,
    this.serviceId,
    this.serviceName,
    this.serviceGroup,
    this.poQty,
    this.unitPrice,
    this.purchaseUOM,
    this.sacCode,
    this.deliveryDate,
    this.taxCode,
    this.taxPercent,
    this.lineTotal,
    this.taxAmt,
    this.finalAmt,
    this.totalReceivedQty,
    this.remainingQty,
  });

  factory GetServicePOItemsModel.fromJson(Map<String, dynamic> json) {
    return GetServicePOItemsModel(
      poTxnID: json['POTxnID'] as int?,
      serviceId: json['ServiceId'] as int?,
      serviceName: json['ServiceName'] as String?,
      serviceGroup: json['ServiceGroup'] as String?,
      poQty: (json['POQty'] as num?)?.toDouble(),
      unitPrice: (json['UnitPrice'] as num?)?.toDouble(),
      purchaseUOM: json['PurchaseUOM'] as String?,
      sacCode: json['SAC_Code'] as String?,
      deliveryDate: json['DeliveryDate'] != null
          ? DateTime.parse(json['DeliveryDate'])
          : null,
      taxCode: json['TaxCode'] as String?,
      taxPercent: (json['TaxPercent'] as num?)?.toDouble(),
      lineTotal: (json['LineTotal'] as num?)?.toDouble(),
      taxAmt: (json['TaxAmt'] as num?)?.toDouble(),
      finalAmt: (json['FinalAmt'] as num?)?.toDouble(),
      totalReceivedQty: (json['TotalReceivedQty'] as num?)?.toDouble(),
      remainingQty: (json['RemainingQty'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'POTxnID': poTxnID,
      'ServiceId': serviceId,
      'ServiceName': serviceName,
      'ServiceGroup': serviceGroup,
      'POQty': poQty,
      'UnitPrice': unitPrice,
      'PurchaseUOM': purchaseUOM,
      'SAC_Code': sacCode,
      'DeliveryDate': deliveryDate?.toIso8601String(),
      'TaxCode': taxCode,
      'TaxPercent': taxPercent,
      'LineTotal': lineTotal,
      'TaxAmt': taxAmt,
      'FinalAmt': finalAmt,
      'TotalReceivedQty': totalReceivedQty,
      'RemainingQty': remainingQty,
    };
  }
}
