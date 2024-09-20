class GRNTransactionDetailsModel {
  String srNo;
  String poTxnID;
  String sapID;
  String itemGroup;
  String itemID;
  String itemName;
  String batchNo;
  String serialNo;
  String poQty;
  String poRate;
  String receivedQty;
  String receivedRate;
  String purchaseUOM;
  String gateEntryID;
  String totalReceivedQuantity;
  String remainingQuantity;
  String acceptedQty;

  GRNTransactionDetailsModel({
    required this.srNo,
    required this.poTxnID,
    required this.sapID,
    required this.itemGroup,
    required this.itemID,
    required this.itemName,
    required this.batchNo,
    required this.serialNo,
    required this.poQty,
    required this.poRate,
    required this.receivedQty,
    required this.receivedRate,
    required this.purchaseUOM,
    required this.gateEntryID,
    required this.totalReceivedQuantity,
    required this.remainingQuantity,
    required this.acceptedQty,
  });

  Map<String, dynamic> toJson() {
    return {
      'SR NO.': srNo,
      'POTxnID': poTxnID,
      'SAPID': sapID,
      'Item_Group': itemGroup,
      'ItemID': itemID,
      'ItemName': itemName,
      'BatchNo': batchNo,
      'SerialNo': serialNo,
      'POQty': poQty,
      'PORate': poRate,
      'ReceivedQty': receivedQty,
      'ReceivedRate': receivedRate,
      'Purchase UOM': purchaseUOM,
      'GateEntryID': gateEntryID,
      'Total Received Quantity': totalReceivedQuantity,
      'Remaining Quantity': remainingQuantity,
      "RemainingQuantity": "2",
      'acceptedQty': acceptedQty,
    };
  }
}
