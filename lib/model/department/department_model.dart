class GetDepartmentModel {
  int? departmentID;
  String? department;
  DateTime? createdOn;

  GetDepartmentModel({
    this.departmentID,
    this.department,
    this.createdOn,
  });

  // fromJson method
  factory GetDepartmentModel.fromJson(Map<String, dynamic> json) {
    return GetDepartmentModel(
      departmentID: json['DepartmentID'] as int?,
      department: json['Department'] as String?,
      createdOn: json['CreatedON'] == null
          ? null
          : DateTime.parse(json['CreatedON'] as String),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'DepartmentID': departmentID,
      'Department': department,
      'CreatedON': createdOn?.toIso8601String(),
    };
  }
}
