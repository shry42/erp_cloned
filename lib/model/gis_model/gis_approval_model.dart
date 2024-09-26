class GISApprovalsModel {
  final int? gisTxnID;
  final String? txnDirection;
  final String? txnDate;
  final int? woTxnID;
  final String? issuedTo;
  final String? projectCode;
  final String? department;
  final String? username;
  final bool? approvalStatus;
  final String? gisStatus;
  final String? gisApprovedBy;
  final String? type;

  GISApprovalsModel({
    this.gisTxnID,
    this.txnDirection,
    this.txnDate,
    this.woTxnID,
    this.issuedTo,
    this.projectCode,
    this.department,
    this.username,
    this.approvalStatus,
    this.gisStatus,
    this.gisApprovedBy,
    this.type,
  });

  factory GISApprovalsModel.fromJson(Map<String, dynamic> json) {
    return GISApprovalsModel(
      gisTxnID: json['GISTxnID'] as int?,
      txnDirection: json['TxnDirection'] as String?,
      txnDate: json['TxnDate'] as String?,
      woTxnID: json['WOTxnID'] as int?,
      issuedTo: json['IssuedTo'] as String?,
      projectCode: json['ProjectCode'] as String?,
      department: json['Department'] as String?,
      username: json['Username'] as String?,
      approvalStatus: json['ApprovalStatus'] as bool?,
      gisStatus: json['GISStatus'] as String?,
      gisApprovedBy: json['GISApprovedBy'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GISTxnID': gisTxnID,
      'TxnDirection': txnDirection,
      'TxnDate': txnDate,
      'WOTxnID': woTxnID,
      'IssuedTo': issuedTo,
      'ProjectCode': projectCode,
      'Department': department,
      'Username': username,
      'ApprovalStatus': approvalStatus,
      'GISStatus': gisStatus,
      'GISApprovedBy': gisApprovedBy,
      'type': type,
    };
  }
}
