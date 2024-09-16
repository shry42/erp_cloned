import 'dart:convert';

class DepartmentFilterModel {
  String prTxnId;
  String txnDate;
  String reqDate;
  String projectCode;
  String approvalStatus;
  String prStatus;
  String username;
  String fullName;

  DepartmentFilterModel(
      {required this.prTxnId,
      required this.txnDate,
      required this.reqDate,
      required this.projectCode,
      required this.approvalStatus,
      required this.prStatus,
      required this.username,
      required this.fullName});

  factory DepartmentFilterModel.fromJson(Map<String, dynamic> json) {
    return DepartmentFilterModel(
        prTxnId: json['PRTxnID'].toString(),
        txnDate: json['TxnDate'].toString(),
        reqDate: json['ReqDate'].toString(),
        projectCode: json['ProjectCode'],
        approvalStatus: json['ApprovalStatus'].toString(),
        prStatus: json['PRStatus'].toString(),
        username: json['Username'],
        fullName: json['FullName']);
  }

  Map<String, dynamic> toJson() => {
        'PRTxnID': prTxnId,
        'TxnDate': txnDate,
        'ReqDate': reqDate,
        'ProjectCode': projectCode,
        'ApprovalStatus': approvalStatus,
        'PRStatus': prStatus,
        'Username': username,
        'FullName': fullName
      };
}
