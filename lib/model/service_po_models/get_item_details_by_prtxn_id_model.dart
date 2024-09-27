class GetServiceItemDetailsByPRTxnIDModel {
  String? serviceName;
  String? serviceGroup;
  int? serviceId;
  int? requestedQty;
  String? purchaseUOM;
  String? remarks;
  int? remainingQty;

  GetServiceItemDetailsByPRTxnIDModel({
    this.serviceName,
    this.serviceGroup,
    this.serviceId,
    this.requestedQty,
    this.purchaseUOM,
    this.remarks,
    this.remainingQty,
  });

  // Factory method to create an instance of the model from a JSON map
  factory GetServiceItemDetailsByPRTxnIDModel.fromJson(
      Map<String, dynamic> json) {
    return GetServiceItemDetailsByPRTxnIDModel(
      serviceName: json['ServiceName'] as String?,
      serviceGroup: json['ServiceGroup'] as String?,
      serviceId: json['serviceId'] as int?,
      requestedQty: json['RequestedQty'] as int?,
      purchaseUOM: json['PurchaseUOM'] as String?,
      remarks: json['Remarks'] as String?,
      remainingQty: json['RemainingQty'] as int?,
    );
  }

  // Method to convert the instance of the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'ServiceName': serviceName,
      'ServiceGroup': serviceGroup,
      'serviceId': serviceId,
      'RequestedQty': requestedQty,
      'PurchaseUOM': purchaseUOM,
      'Remarks': remarks,
      'RemainingQty': remainingQty,
    };
  }
}
