class GetWoDetailsStatusModel {
  int? woTxnID;
  int? designID;
  int? wiSetID;
  DateTime? woCreationDate;
  DateTime? woForDate;
  String? projectCode;
  String? department;
  int? userID;
  bool? woApprovalStatus;
  String? woStatus;

  GetWoDetailsStatusModel({
    this.woTxnID,
    this.designID,
    this.wiSetID,
    this.woCreationDate,
    this.woForDate,
    this.projectCode,
    this.department,
    this.userID,
    this.woApprovalStatus,
    this.woStatus,
  });

  // From JSON method
  factory GetWoDetailsStatusModel.fromJson(Map<String, dynamic> json) {
    return GetWoDetailsStatusModel(
      woTxnID: json['WOTxnID'] as int?,
      designID: json['DesignID'] as int?,
      wiSetID: json['WISet_ID'] as int?,
      woCreationDate: json['WOCreationDate'] != null
          ? DateTime.parse(json['WOCreationDate'] as String)
          : null,
      woForDate: json['WOForDate'] != null
          ? DateTime.parse(json['WOForDate'] as String)
          : null,
      projectCode: json['ProjectCode'] as String?,
      department: json['Department'] as String?,
      userID: json['UserID'] as int?,
      woApprovalStatus: json['WOApprovalStatus'] as bool?,
      woStatus: json['WOStatus'] as String?,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'WOTxnID': woTxnID,
      'DesignID': designID,
      'WISet_ID': wiSetID,
      'WOCreationDate': woCreationDate?.toIso8601String(),
      'WOForDate': woForDate?.toIso8601String(),
      'ProjectCode': projectCode,
      'Department': department,
      'UserID': userID,
      'WOApprovalStatus': woApprovalStatus,
      'WOStatus': woStatus,
    };
  }
}
