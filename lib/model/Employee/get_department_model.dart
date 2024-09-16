class GetDepartmentListModel {
  final String? department;

  GetDepartmentListModel({this.department});

  factory GetDepartmentListModel.fromJson(Map<String, dynamic> json) {
    return GetDepartmentListModel(
      department: json['Department'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Department': department,
    };
  }
}
