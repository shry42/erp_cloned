class ServiceGRNTransactionDetailsModel {
  final String? srNo;
  final String? poTxnId;
  final String? serviceId;
  final String? serviceName;
  final String? serviceGroup;
  final String? batchNumber;
  final String? serialNumber;
  final String? poQuantity;
  final String? poRate;
  final String? receivedQuantity;
  final String? receivedRate;
  final String? gateEntryId;
  final String? purchaseUOM;
  final String? totalReceivedQuantity;
  final String? remainingQuantity;

  ServiceGRNTransactionDetailsModel({
    this.srNo,
    this.poTxnId,
    this.serviceId,
    this.serviceName,
    this.serviceGroup,
    this.batchNumber,
    this.serialNumber,
    this.poQuantity,
    this.poRate,
    this.receivedQuantity,
    this.receivedRate,
    this.gateEntryId,
    this.purchaseUOM,
    this.totalReceivedQuantity,
    this.remainingQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'SR NO.': srNo,
      'POTxnID': poTxnId,
      'ServiceId': serviceId,
      'ServiceName': serviceName,
      'ServiceGroup': serviceGroup,
      'BatchNo': batchNumber,
      'SerialNo': serialNumber,
      'POQty': poQuantity,
      'PORate': poRate ?? '',
      'ReceivedQty': receivedQuantity,
      'ReceivedRate': receivedRate,
      'GateEntryID': gateEntryId,
      'Purchase UOM': purchaseUOM,
      'Total Received Quantity': totalReceivedQuantity,
      'Remaining Quantity': remainingQuantity,
      "RemainingQuantity": "Remove",
    };
  }
}
