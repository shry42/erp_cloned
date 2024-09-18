class GetGateEntryLogModel {
  final int? gateEntryID;
  final String? challanNo;
  final DateTime? challanDate;
  final int? poID;
  final String? poCode;
  final String? itemCount;
  final DateTime? receivedDate;
  final int? receivedByUserID;
  final String? receivedByUser;
  final int? authorizerUserID;
  final String? authorizerUserName;
  final String? remarks;
  final bool? isPOLinked;
  final bool? grnDone;

  GetGateEntryLogModel({
    this.gateEntryID,
    this.challanNo,
    this.challanDate,
    this.poID,
    this.poCode,
    this.itemCount,
    this.receivedDate,
    this.receivedByUserID,
    this.receivedByUser,
    this.authorizerUserID,
    this.authorizerUserName,
    this.remarks,
    this.isPOLinked,
    this.grnDone,
  });

  factory GetGateEntryLogModel.fromJson(Map<String, dynamic> json) {
    return GetGateEntryLogModel(
      gateEntryID:
          json['GateEntryID'] != null ? json['GateEntryID'] as int? : null,
      challanNo:
          json['ChallanNo'] != null && (json['ChallanNo'] as String).isNotEmpty
              ? json['ChallanNo'] as String
              : null,
      challanDate: json['ChallanDate'] != null &&
              (json['ChallanDate'] as String).isNotEmpty
          ? DateTime.tryParse(json['ChallanDate'])
          : null,
      poID: json['POID'] != null ? json['POID'] as int? : null,
      poCode: json['POCode'] != null && (json['POCode'] as String).isNotEmpty
          ? json['POCode'] as String
          : null,
      itemCount:
          json['ItemCount'] != null && (json['ItemCount'] as String).isNotEmpty
              ? json['ItemCount'] as String
              : null,
      receivedDate:
          json['RcvdDate'] != null && (json['RcvdDate'] as String).isNotEmpty
              ? DateTime.tryParse(json['RcvdDate'])
              : null,
      receivedByUserID:
          json['RcvdByUserID'] != null ? json['RcvdByUserID'] as int? : null,
      receivedByUser: json['RcvdByUser'] != null &&
              (json['RcvdByUser'] as String).isNotEmpty
          ? json['RcvdByUser'] as String
          : null,
      authorizerUserID: json['AuthorizerUserID'] != null
          ? json['AuthorizerUserID'] as int?
          : null,
      authorizerUserName: json['AuthorizerUserName'] != null &&
              (json['AuthorizerUserName'] as String).isNotEmpty
          ? json['AuthorizerUserName'] as String
          : null,
      remarks: json['Remarks'] != null && (json['Remarks'] as String).isNotEmpty
          ? json['Remarks'] as String
          : null,
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
      'RcvdDate': receivedDate?.toIso8601String(),
      'RcvdByUserID': receivedByUserID,
      'RcvdByUser': receivedByUser,
      'AuthorizerUserID': authorizerUserID,
      'AuthorizerUserName': authorizerUserName,
      'Remarks': remarks,
      'IsPOLinked': isPOLinked,
      'GRNDone': grnDone,
    };
  }
}
