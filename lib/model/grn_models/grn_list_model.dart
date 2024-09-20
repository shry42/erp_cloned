class GRNListModel {
  int? grnTxnID;
  String? txnDirection;
  DateTime? txnDate;
  int? userID;
  bool? grnApprovalStatus;
  bool? focSampleFlag;
  bool? grnRejected;
  String? remarks;
  String? invoiceNo;
  String? invoiceDate; // Keeping this as String if the API returns a string
  String? challanNo;
  DateTime? approvedAt;
  DateTime? rejectedAt;
  String? grnStatus;
  int? approvedBy;
  String? fullName;

  GRNListModel({
    this.grnTxnID,
    this.txnDirection,
    this.txnDate,
    this.userID,
    this.grnApprovalStatus,
    this.focSampleFlag,
    this.grnRejected,
    this.remarks,
    this.invoiceNo,
    this.invoiceDate,
    this.challanNo,
    this.approvedAt,
    this.rejectedAt,
    this.grnStatus,
    this.approvedBy,
    this.fullName,
  });

  // Factory constructor to create the model from JSON
  factory GRNListModel.fromJson(Map<String, dynamic> json) {
    return GRNListModel(
      grnTxnID: json['GRNTxnID'] as int?,
      txnDirection: json['TxnDirection'] as String?,
      txnDate: json['TxnDate'] != null
          ? DateTime.tryParse(
              json['TxnDate']) // Handle potential parsing issues
          : null,
      userID: json['UserID'] as int?,
      grnApprovalStatus: json['GRNApprovalStatus'] as bool?,
      focSampleFlag: json['FOCSampleFlag'] as bool?,
      grnRejected: json['GRNRejected'] as bool?,
      remarks: json['remarks'] as String?,
      invoiceNo: json['invoiceNo'] as String?,
      invoiceDate: json['invoiceDate']
          as String?, // Keep it as a string if it comes as a string
      challanNo: json['challanNo'] as String?,
      approvedAt: json['approvedAt'] != null
          ? DateTime.tryParse(
              json['approvedAt']) // Handle null or incorrect formats
          : null,
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.tryParse(json['rejectedAt'])
          : null,
      grnStatus: json['GRNStatus'] as String?,
      approvedBy: json['approvedBy'] as int?,
      fullName: json['FullName'] as String?,
    );
  }

  // Convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'GRNTxnID': grnTxnID,
      'TxnDirection': txnDirection,
      'TxnDate': txnDate?.toIso8601String(),
      'UserID': userID,
      'GRNApprovalStatus': grnApprovalStatus,
      'FOCSampleFlag': focSampleFlag,
      'GRNRejected': grnRejected,
      'remarks': remarks,
      'invoiceNo': invoiceNo,
      'invoiceDate': invoiceDate, // No conversion if it is a string
      'challanNo': challanNo,
      'approvedAt': approvedAt?.toIso8601String(),
      'rejectedAt': rejectedAt?.toIso8601String(),
      'GRNStatus': grnStatus,
      'approvedBy': approvedBy,
      'FullName': fullName,
    };
  }
}
