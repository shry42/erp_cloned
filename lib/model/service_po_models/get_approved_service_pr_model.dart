class GetApprovedServicePRModel {
  int? prTxnID;
  DateTime? txnDate;
  DateTime? reqDate;
  String? projectCode;
  String? department;
  int? userID;
  bool? approvalStatus;
  String? prStatus;
  DateTime? approvedAt;
  DateTime? rejectedAt;
  DateTime? prClosingTime;

  GetApprovedServicePRModel({
    this.prTxnID,
    this.txnDate,
    this.reqDate,
    this.projectCode,
    this.department,
    this.userID,
    this.approvalStatus,
    this.prStatus,
    this.approvedAt,
    this.rejectedAt,
    this.prClosingTime,
  });

  factory GetApprovedServicePRModel.fromJson(Map<String, dynamic> json) {
    return GetApprovedServicePRModel(
      prTxnID: json['PRTxnID'] as int?,
      txnDate: json['TxnDate'] != null
          ? DateTime.parse(json['TxnDate'] as String)
          : null,
      reqDate: json['ReqDate'] != null
          ? DateTime.parse(json['ReqDate'] as String)
          : null,
      projectCode: json['ProjectCode'] as String?,
      department: json['Department'] as String?,
      userID: json['UserID'] as int?,
      approvalStatus: json['ApprovalStatus'] as bool?,
      prStatus: json['PRStatus'] as String?,
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'] as String)
          : null,
      rejectedAt: json['rejectedAt'] != null
          ? DateTime.parse(json['rejectedAt'] as String)
          : null,
      prClosingTime: json['PRClosingTime'] != null
          ? DateTime.parse(json['PRClosingTime'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PRTxnID': prTxnID,
      'TxnDate': txnDate?.toIso8601String(),
      'ReqDate': reqDate?.toIso8601String(),
      'ProjectCode': projectCode,
      'Department': department,
      'UserID': userID,
      'ApprovalStatus': approvalStatus,
      'PRStatus': prStatus,
      'approvedAt': approvedAt?.toIso8601String(),
      'rejectedAt': rejectedAt?.toIso8601String(),
      'PRClosingTime': prClosingTime?.toIso8601String(),
    };
  }
}
