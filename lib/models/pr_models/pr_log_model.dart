import 'dart:convert';

class PrLogModel {
  int prTxnId;
  String txnDate;
  String reqDate;
  String projectCode;
  String approvalStatus;
  String prStatus;
  String? username = "NA";

  PrLogModel({
    required this.prTxnId,
    required this.txnDate,
    required this.reqDate,
    required this.projectCode,
    required this.approvalStatus,
    required this.prStatus,
    this.username,
  });

  factory PrLogModel.fromJson(Map<String, dynamic> json) => PrLogModel(
        prTxnId: json["PRTxnID"],
        txnDate: (json["TxnDate"]),
        reqDate: (json["ReqDate"]),
        projectCode: json["ProjectCode"],
        approvalStatus: json["ApprovalStatus"].toString(),
        prStatus: json["PRStatus"],
      );

  Map<String, dynamic> toJson() => {
        "PRTxnID": prTxnId,
        "TxnDate": txnDate,
        "ReqDate": reqDate,
        "ProjectCode": projectCode,
        "ApprovalStatus": approvalStatus.toString(),
        "PRStatus": prStatus,
      };
}
