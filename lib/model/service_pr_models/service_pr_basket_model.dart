class ServicePRBasket {
  final String srNo;
  final String projectCode;
  final String prNumber;
  final String requiredBy;
  final String serviceName;
  final String serviceGroup;
  final String quantity;
  final String purchaseUOM;
  final String remark;
  final String description;
  final String prDate;

  ServicePRBasket(
      {required this.srNo,
      required this.prNumber,
      required this.requiredBy,
      required this.projectCode,
      required this.serviceGroup,
      required this.serviceName,
      required this.quantity,
      required this.purchaseUOM,
      required this.remark,
      required this.description,
      required this.prDate});
}
