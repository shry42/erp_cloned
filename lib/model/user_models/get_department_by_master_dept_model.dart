class DeptListByMasterModel {
  final int? departmentID;
  final String? department;
  final DateTime? createdON;

  DeptListByMasterModel({this.departmentID, this.department, this.createdON});

  factory DeptListByMasterModel.fromJson(Map<String, dynamic> json) {
    return DeptListByMasterModel(
      departmentID: json['DepartmentID'] as int?,
      department: json['Department'] as String?,
      createdON:
          json['CreatedON'] != null ? DateTime.parse(json['CreatedON']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DepartmentID': departmentID,
      'Department': department,
      'CreatedON': createdON?.toIso8601String(),
    };
  }
}
