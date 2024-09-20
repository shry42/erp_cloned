class GetRejectedItemListModel {
  String? itemID;
  String? poTxnID;
  String? grnTxnID;
  String? grnDetailsID;
  String? qty;
  String? createdAt;
  String? isActive;
  String? amount;
  String? amountWithTax;
  String? itemName;
  String? sapID;
  String? itemGroup;
  String? poStatus;
  String? vendorCurrency;

  GetRejectedItemListModel({
    this.itemID,
    this.poTxnID,
    this.grnTxnID,
    this.grnDetailsID,
    this.qty,
    this.createdAt,
    this.isActive,
    this.amount,
    this.amountWithTax,
    this.itemName,
    this.sapID,
    this.itemGroup,
    this.poStatus,
    this.vendorCurrency,
  });

  factory GetRejectedItemListModel.fromJson(Map<String, dynamic> json) {
    return GetRejectedItemListModel(
      itemID: json['ItemID'].toString(),
      poTxnID: json['POTxnID'].toString(),
      grnTxnID: json['GRNTxnID'].toString(),
      grnDetailsID: json['GRNDetailsID'].toString(),
      qty: json['qty'].toString(),
      createdAt: json['createdAt'].toString(),
      isActive: json['isActive'].toString(), // Assuming 1 means true
      amount: json['amount'],
      amountWithTax: json['amountWithTax'],
      itemName: json['Item_Name'],
      sapID: json['SAP_ID'],
      itemGroup: json['Item_Group'],
      poStatus: json['POStatus'],
      vendorCurrency: json['VendorCurrency'],
    );
  }
}
