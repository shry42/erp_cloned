class MasterMenuListModel {
  final int? id;
  final String? menuName;
  final String? menuIcon;
  final DateTime? createdAt;
  final int? createdBy;
  final int? isActive;

  MasterMenuListModel({
    this.id,
    this.menuName,
    this.menuIcon,
    this.createdAt,
    this.createdBy,
    this.isActive,
  });

  factory MasterMenuListModel.fromJson(Map<String, dynamic> json) {
    return MasterMenuListModel(
      id: json['id'] as int?,
      menuName: json['menuName'] as String?,
      menuIcon: json['menuIcon'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      createdBy: json['createdBy'] as int?,
      isActive: json['isActive'] as int?,
    );
  }
}
