import 'dart:convert';

class PrLogModel {
  int prTxnId;
  String txnDate;
  String reqDate;
  String projectCode;
  bool approvalStatus; // Bool type for ApprovalStatus
  String prStatus;
  String? department; // Added department field
  String? approvedAt; // Added approvedAt field
  String? username = "NA";

  PrLogModel({
    required this.prTxnId,
    required this.txnDate,
    required this.reqDate,
    required this.projectCode,
    required this.approvalStatus,
    required this.prStatus,
    this.department,
    this.approvedAt,
    this.username,
  });

  factory PrLogModel.fromJson(Map<String, dynamic> json) => PrLogModel(
        prTxnId: json["PRTxnID"],
        txnDate: json["TxnDate"],
        reqDate: json["ReqDate"],
        projectCode: json["ProjectCode"],
        // Convert ApprovalStatus to a bool if it's a string
        approvalStatus: json["ApprovalStatus"] is bool
            ? json["ApprovalStatus"]
            : json["ApprovalStatus"].toString().toLowerCase() == 'true',
        prStatus: json["PRStatus"],
        department: json["Department"], // Added department mapping
        approvedAt: json["approvedAt"], // Added approvedAt mapping
      );

  Map<String, dynamic> toJson() => {
        "PRTxnID": prTxnId,
        "TxnDate": txnDate,
        "ReqDate": reqDate,
        "ProjectCode": projectCode,
        "ApprovalStatus": approvalStatus, // Keep as bool
        "PRStatus": prStatus,
        "Department": department, // Include department in JSON output
        "approvedAt": approvedAt, // Include approvedAt in JSON output
      };
}
