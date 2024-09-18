class GRNBasketItem {
  final String? srNo;
  final String? poTxnId;
  final String? venusId;
  final String? itemGroup;
  final String? itemId;
  final String? itemName;
  final String batchNumber;
  final String serialNumber;
  final int? poQuantity;
  final double? unitPrice;
  final String? receivedQuantity; // New field for received quantity
  final String? receivedRate; // New field for received rate
  late final String? gateEntryId; // New field for gate entry ID
  final String? purchaseUOM;
  final String? totalReceivedQuantity;
  final String? remainingQuantity;
  final String? acceptedQuantity;

  GRNBasketItem(
      {this.srNo,
      this.poTxnId,
      this.venusId,
      this.itemGroup,
      this.itemId,
      this.itemName,
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
      this.acceptedQuantity});

  // Update copyWith method to include new fields
  GRNBasketItem copyWith({
    String? batchNumber,
    String? serialNumber,
    String? receivedQuantity,
    String? receivedRate,
    String? gateEntryId,
  }) {
    return GRNBasketItem(
      srNo: this.srNo,
      poTxnId: this.poTxnId,
      venusId: this.venusId,
      itemGroup: this.itemGroup,
      itemId: this.itemId,
      itemName: this.itemName,
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
      acceptedQuantity: this.acceptedQuantity,
    );
  }
}
