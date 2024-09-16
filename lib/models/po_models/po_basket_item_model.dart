class POBasketItem {
  final String srNo;
  final String itemId;
  final String venusId;
  final String itemName;
  final String itemGroup;
  final String hsnCode;
  final String poQuantity;
  final String uom;
  final String deliveryDate;
  final String unitPrice;
  final String taxCode;
  final String taxRate;
  final String lineTotal;
  final String taxAmount;
  final String finalAmount;

  POBasketItem({
    required this.srNo,
    required this.itemId,
    required this.venusId,
    required this.itemName,
    required this.itemGroup,
    required this.hsnCode,
    required this.poQuantity,
    required this.uom,
    required this.deliveryDate,
    required this.unitPrice,
    required this.taxCode,
    required this.taxRate,
    required this.lineTotal,
    required this.taxAmount,
    required this.finalAmount,
  });
}
