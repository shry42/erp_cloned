class BasketItem {
  final String srNo;
  final String venusId;
  final String prNumber;
  final String requiredBy;
  final String internalCode;
  final String quantity;
  final String uom;
  final String remark;

  BasketItem({
    required this.srNo,
    required this.prNumber,
    required this.requiredBy,
    required this.venusId,
    required this.internalCode,
    required this.quantity,
    required this.uom,
    required this.remark,
  });
}
