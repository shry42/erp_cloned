class ProjectcodelistModel {
  int? projectID;
  String? projectName;
  String? projectDepartment;
  String? projectCode;
  String? createdOn;

  ProjectcodelistModel({
    this.projectID,
    this.projectName,
    this.projectDepartment,
    this.projectCode,
    this.createdOn,
  });

  factory ProjectcodelistModel.fromJson(Map<String, dynamic> json) {
    return ProjectcodelistModel(
      projectID: json['ProjectID'] as int?,
      projectName: json['ProjectName'] as String?,
      projectDepartment: json['ProjectDepartment'] as String?,
      projectCode: json['ProjectCode'] as String?,
      createdOn: json['CreatedOn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProjectID': projectID,
      'ProjectName': projectName,
      'ProjectDepartment': projectDepartment,
      'ProjectCode': projectCode,
      'CreatedOn': createdOn,
    };
  }
}
