class MasterSubMenuListModel {
  final int? id;
  final String? subMenuName;
  final String? subMenuIcon;
  final String? subMenuUrl;
  final DateTime? createdAt;
  final int? createdBy;
  final int? isActive;
  final int? masterMenuId;

  MasterSubMenuListModel({
    this.id,
    this.subMenuName,
    this.subMenuIcon,
    this.subMenuUrl,
    this.createdAt,
    this.createdBy,
    this.isActive,
    this.masterMenuId,
  });

  factory MasterSubMenuListModel.fromJson(Map<String, dynamic> json) {
    return MasterSubMenuListModel(
      id: json['id'] as int?,
      subMenuName: json['subMenuName'] as String?,
      subMenuIcon: json['subMenuIcon'] as String?,
      subMenuUrl: json['subMenuUrl'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      createdBy: json['createdBy'] as int?,
      isActive: json['isActive'] as int?,
      masterMenuId: json['masterMenuId'] as int?,
    );
  }
}
