class GRNTransactionDetails {
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

  GRNTransactionDetails({
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
      'srNo': srNo,
      'poTxnID': poTxnID,
      'sapID': sapID,
      'itemGroup': itemGroup,
      'itemID': itemID,
      'itemName': itemName,
      'batchNo': batchNo,
      'serialNo': serialNo,
      'poQty': poQty,
      'poRate': poRate,
      'receivedQty': receivedQty,
      'receivedRate': receivedRate,
      'purchaseUOM': purchaseUOM,
      'gateEntryID': gateEntryID,
      'totalReceivedQuantity': totalReceivedQuantity,
      'remainingQuantity': remainingQuantity,
      'acceptedQty': acceptedQty,
    };
  }
}
