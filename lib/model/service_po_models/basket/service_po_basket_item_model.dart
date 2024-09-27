class ServicePOBasketItem {
  final String srNo;
  final String serviceID;
  final String serviceName;
  final String serviceGroup;
  final String sacCode;
  final String poQuantity;
  final String uom;
  final String deliveryDate;
  final String unitPrice;
  final String taxCode;
  final String taxRate;
  final String lineTotal;
  final String taxAmount;
  final String finalAmount;

  ServicePOBasketItem({
    required this.srNo,
    required this.serviceID,
    required this.serviceName,
    required this.serviceGroup,
    required this.sacCode,
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
