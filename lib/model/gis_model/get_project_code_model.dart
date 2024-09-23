class GetProjectCodeGISModel {
  final int projectID;
  final String projectName;
  final String projectDepartment;
  final String projectCode;
  final DateTime createdOn;

  GetProjectCodeGISModel({
    required this.projectID,
    required this.projectName,
    required this.projectDepartment,
    required this.projectCode,
    required this.createdOn,
  });

  factory GetProjectCodeGISModel.fromJson(Map<String, dynamic> json) {
    return GetProjectCodeGISModel(
      projectID: json['ProjectID'],
      projectName: json['ProjectName'],
      projectDepartment: json['ProjectDepartment'],
      projectCode: json['ProjectCode'],
      createdOn: DateTime.parse(json['CreatedOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProjectID': projectID,
      'ProjectName': projectName,
      'ProjectDepartment': projectDepartment,
      'ProjectCode': projectCode,
      'CreatedOn': createdOn.toIso8601String(),
    };
  }
}
