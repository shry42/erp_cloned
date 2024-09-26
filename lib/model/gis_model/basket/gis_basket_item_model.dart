class GISBasketItem {
  final String venusId;
  final int itemId;
  final String internalCode;
  final String batchNo;
  final String serialNo;
  final double reqQuantity;
  final double issuedQuantity;
  final String uom;
  final String remarks;

  GISBasketItem({
    required this.venusId,
    required this.itemId,
    required this.internalCode,
    required this.batchNo,
    required this.serialNo,
    required this.reqQuantity,
    required this.issuedQuantity,
    required this.uom,
    required this.remarks,
  });

  double get differenceQty => reqQuantity - issuedQuantity;
  double get balanceQty => reqQuantity - issuedQuantity;
}
