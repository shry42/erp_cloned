class GetAllGRNListModel {
  final int grnTxnID;
  final DateTime txnDate;
  final String username;
  final bool grnApprovalStatus;
  final bool grnRejected;
  final String? vendorName;
  final String? invoiceNo;
  final DateTime? invoiceDate;
  final String? challanNo;

  GetAllGRNListModel({
    required this.grnTxnID,
    required this.txnDate,
    required this.username,
    required this.grnApprovalStatus,
    required this.grnRejected,
    this.vendorName,
    this.invoiceNo,
    this.invoiceDate,
    this.challanNo,
  });

  factory GetAllGRNListModel.fromJson(Map<String, dynamic> json) {
    return GetAllGRNListModel(
      grnTxnID: json['GRNTxnID'],
      txnDate: DateTime.parse(json['TxnDate']),
      username: json['Username'],
      grnApprovalStatus: json['GRNApprovalStatus'],
      grnRejected: json['GRNRejected'],
      vendorName: json['VendorName'],
      invoiceNo: json['invoiceNo'],
      invoiceDate: json['invoiceDate'] != null
          ? DateTime.parse(json['invoiceDate'])
          : null,
      challanNo: json['challanNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GRNTxnID': grnTxnID,
      'TxnDate': txnDate.toIso8601String(),
      'Username': username,
      'GRNApprovalStatus': grnApprovalStatus,
      'GRNRejected': grnRejected,
      'VendorName': vendorName,
      'invoiceNo': invoiceNo,
      'invoiceDate': invoiceDate?.toIso8601String(),
      'challanNo': challanNo,
    };
  }
}
