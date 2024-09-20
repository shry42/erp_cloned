class GRNListInApprovalModel {
  int? grnDetailsID;
  double? acceptedQty;
  int? poTxnID;
  String? poCode;
  DateTime? poDate;
  String? vendorName;
  int? itemID;
  String? itemName;
  String? itemGroup;
  String? sapID;
  int? vendorID;
  double? taxPercent;
  String? batchNo;
  String? serialNo;
  double? poQty;
  double? poRate;
  double? receivedQty;
  double? receivedRate;
  String? purchaseUOM;
  int? gateEntryID;
  double? rejectedQty;
  double? acceptedQtyValue;
  double? rejectedQtyValue;
  double? acceptedValueTaxAmount;
  double? rejectedValueTaxAmount;
  String? vendorCurrency;
  bool? inventoryItem;

  GRNListInApprovalModel({
    this.grnDetailsID,
    this.acceptedQty,
    this.poTxnID,
    this.poCode,
    this.poDate,
    this.vendorName,
    this.itemID,
    this.itemName,
    this.itemGroup,
    this.sapID,
    this.vendorID,
    this.taxPercent,
    this.batchNo,
    this.serialNo,
    this.poQty,
    this.poRate,
    this.receivedQty,
    this.receivedRate,
    this.purchaseUOM,
    this.gateEntryID,
    this.rejectedQty,
    this.acceptedQtyValue,
    this.rejectedQtyValue,
    this.acceptedValueTaxAmount,
    this.rejectedValueTaxAmount,
    this.vendorCurrency,
    this.inventoryItem,
  });

  // Factory method to create an instance from JSON
  factory GRNListInApprovalModel.fromJson(Map<String, dynamic> json) {
    return GRNListInApprovalModel(
      grnDetailsID: json['GRNDetailsID'],
      acceptedQty:
          (json['acceptedQty'] != null) ? json['acceptedQty'].toDouble() : null,
      poTxnID: json['POTxnID'],
      poCode: json['POCode'],
      poDate: json['PODate'] != null ? DateTime.parse(json['PODate']) : null,
      vendorName: json['VendorName'],
      itemID: json['ItemID'],
      itemName: json['ItemName'],
      itemGroup: json['Item_Group'],
      sapID: json['SAP_ID'],
      vendorID: json['VendorID'],
      taxPercent:
          json['TaxPercent'] != null ? json['TaxPercent'].toDouble() : null,
      batchNo: json['BatchNo'],
      serialNo: json['SerialNo'],
      poQty: json['POQty'] != null ? json['POQty'].toDouble() : null,
      poRate: json['PORate'] != null ? json['PORate'].toDouble() : null,
      receivedQty:
          json['ReceivedQty'] != null ? json['ReceivedQty'].toDouble() : null,
      receivedRate:
          json['ReceivedRate'] != null ? json['ReceivedRate'].toDouble() : null,
      purchaseUOM: json['Purchase_UOM'],
      gateEntryID: json['GateEntryID'],
      rejectedQty:
          json['rejectedQty'] != null ? json['rejectedQty'].toDouble() : null,
      acceptedQtyValue: json['acceptedQtyValue'] != null
          ? json['acceptedQtyValue'].toDouble()
          : null,
      rejectedQtyValue: json['rejectedQtyValue'] != null
          ? json['rejectedQtyValue'].toDouble()
          : null,
      acceptedValueTaxAmount: json['accepetedValueTaxAmount'] != null
          ? json['accepetedValueTaxAmount'].toDouble()
          : null,
      rejectedValueTaxAmount: json['rejectedValueTaxAmount'] != null
          ? json['rejectedValueTaxAmount'].toDouble()
          : null,
      vendorCurrency: json['VendorCurrency'],
      inventoryItem: json['Inventory_Item'],
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'GRNDetailsID': grnDetailsID,
      'acceptedQty': acceptedQty,
      'POTxnID': poTxnID,
      'POCode': poCode,
      'PODate': poDate?.toIso8601String(),
      'VendorName': vendorName,
      'ItemID': itemID,
      'ItemName': itemName,
      'Item_Group': itemGroup,
      'SAP_ID': sapID,
      'VendorID': vendorID,
      'TaxPercent': taxPercent,
      'BatchNo': batchNo,
      'SerialNo': serialNo,
      'POQty': poQty,
      'PORate': poRate,
      'ReceivedQty': receivedQty,
      'ReceivedRate': receivedRate,
      'Purchase_UOM': purchaseUOM,
      'GateEntryID': gateEntryID,
      'rejectedQty': rejectedQty,
      'acceptedQtyValue': acceptedQtyValue,
      'rejectedQtyValue': rejectedQtyValue,
      'accepetedValueTaxAmount': acceptedValueTaxAmount,
      'rejectedValueTaxAmount': rejectedValueTaxAmount,
      'VendorCurrency': vendorCurrency,
      'Inventory_Item': inventoryItem,
    };
  }
}
