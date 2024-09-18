class GetGateEntryNumberFromPoIDModel {
  int? gateEntryID;
  String? challanNo;
  DateTime? challanDate;
  int? poID;
  String? poCode;
  String? itemCount;
  DateTime? rcvdDate;
  int? rcvdByUserID;
  String? rcvdByUser;
  int? authorizerUserID;
  String? authorizerUserName;
  String? remarks;
  bool? isPOLinked;
  bool? grnDone;

  GetGateEntryNumberFromPoIDModel({
    this.gateEntryID,
    this.challanNo,
    this.challanDate,
    this.poID,
    this.poCode,
    this.itemCount,
    this.rcvdDate,
    this.rcvdByUserID,
    this.rcvdByUser,
    this.authorizerUserID,
    this.authorizerUserName,
    this.remarks,
    this.isPOLinked,
    this.grnDone,
  });

  factory GetGateEntryNumberFromPoIDModel.fromJson(Map<String, dynamic> json) {
    return GetGateEntryNumberFromPoIDModel(
      gateEntryID: json['GateEntryID'] as int?,
      challanNo: json['ChallanNo'] as String?,
      challanDate: json['ChallanDate'] != null
          ? DateTime.parse(json['ChallanDate'] as String)
          : null,
      poID: json['POID'] as int?,
      poCode: json['POCode'] as String?,
      itemCount: json['ItemCount'] as String?,
      rcvdDate: json['RcvdDate'] != null
          ? DateTime.parse(json['RcvdDate'] as String)
          : null,
      rcvdByUserID: json['RcvdByUserID'] as int?,
      rcvdByUser: json['RcvdByUser'] as String?,
      authorizerUserID: json['AuthorizerUserID'] as int?,
      authorizerUserName: json['AuthorizerUserName'] as String?,
      remarks: json['Remarks'] as String?,
      isPOLinked: json['IsPOLinked'] as bool?,
      grnDone: json['GRNDone'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GateEntryID': gateEntryID,
      'ChallanNo': challanNo,
      'ChallanDate': challanDate?.toIso8601String(),
      'POID': poID,
      'POCode': poCode,
      'ItemCount': itemCount,
      'RcvdDate': rcvdDate?.toIso8601String(),
      'RcvdByUserID': rcvdByUserID,
      'RcvdByUser': rcvdByUser,
      'AuthorizerUserID': authorizerUserID,
      'AuthorizerUserName': authorizerUserName,
      'Remarks': remarks,
      'IsPOLinked': isPOLinked,
      'GRNDone': grnDone,
    };
  }
}
