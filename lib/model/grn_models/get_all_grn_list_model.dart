class GetAllGRNListModel {
  final int grnTxnID;
  final DateTime txnDate;
  final String username;
  final bool grnApprovalStatus;
  final bool grnRejected;
  final String? vendorName;
  final String? invoiceNo;
  final String? invoiceDate;
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
      invoiceDate: json['invoiceDate'].toString(),
      challanNo: json['challanNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GRNTxnID': grnTxnID,
      'TxnDate': txnDate,
      'Username': username,
      'GRNApprovalStatus': grnApprovalStatus,
      'GRNRejected': grnRejected,
      'VendorName': vendorName,
      'invoiceNo': invoiceNo,
      'invoiceDate': invoiceDate,
      'challanNo': challanNo,
    };
  }
}
