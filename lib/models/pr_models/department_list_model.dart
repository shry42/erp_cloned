class DepartmentListModel {
  String? depName;

  DepartmentListModel({
    this.depName,
  });

  factory DepartmentListModel.fromJson(Map<String, dynamic> json) {
    return DepartmentListModel(
      depName: json['Department'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Department': depName,
      };
}
