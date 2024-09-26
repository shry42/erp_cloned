class ServiceGRNBasketItem {
  final String? srNo;
  final String? poTxnId;
  final String? serviceId;
  final String? serviceName;
  final String? serviceGroup;
  final String batchNumber;
  final String serialNumber;
  final String? poQuantity;
  final String? unitPrice;
  final String? receivedQuantity; // New field for received quantity
  final String? receivedRate; // New field for received rate
  late final String? gateEntryId; // New field for gate entry ID
  final String? purchaseUOM;
  final String? totalReceivedQuantity;
  final String? remainingQuantity;

  ServiceGRNBasketItem({
    this.srNo,
    this.poTxnId,
    this.serviceId,
    this.serviceName,
    this.serviceGroup,
    this.batchNumber = '',
    this.serialNumber = '',
    this.poQuantity,
    this.unitPrice,
    this.receivedQuantity = '',
    this.receivedRate = '', // Initialize default to 0.0
    this.gateEntryId = '', // Initialize default to empty string
    this.purchaseUOM,
    this.totalReceivedQuantity,
    this.remainingQuantity,
  });

  // Update copyWith method to include new fields
  ServiceGRNBasketItem copyWith({
    String? batchNumber,
    String? serialNumber,
    String? receivedQuantity,
    String? receivedRate,
    String? gateEntryId,
  }) {
    return ServiceGRNBasketItem(
      srNo: this.srNo,
      poTxnId: this.poTxnId,
      serviceId: this.serviceId,
      serviceGroup: this.serviceGroup,
      serviceName: this.serviceName,
      batchNumber: batchNumber ?? this.batchNumber,
      serialNumber: serialNumber ?? this.serialNumber,
      poQuantity: this.poQuantity,
      unitPrice: this.unitPrice,
      receivedQuantity: receivedQuantity ?? this.receivedQuantity,
      receivedRate: receivedRate ?? this.receivedRate,
      gateEntryId: gateEntryId ?? this.gateEntryId,
      purchaseUOM: this.purchaseUOM,
      totalReceivedQuantity: this.totalReceivedQuantity,
      remainingQuantity: this.remainingQuantity,
    );
  }
}
