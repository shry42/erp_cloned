class GetSubMenuIdlistModel {
  final DateTime? createdAt;
  final int? createdBy;
  final int? id;
  final int? isActive;
  final int? masterMenuId;
  final String? menuName;
  final String? subMenuIcon;
  final String? subMenuName;
  final String? subMenuUrl;

  GetSubMenuIdlistModel({
    this.createdAt,
    this.createdBy,
    this.id,
    this.isActive,
    this.masterMenuId,
    this.menuName,
    this.subMenuIcon,
    this.subMenuName,
    this.subMenuUrl,
  });

  factory GetSubMenuIdlistModel.fromJson(Map<String, dynamic> json) {
    return GetSubMenuIdlistModel(
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      createdBy: json['createdBy'],
      id: json['id'],
      isActive: json['isActive'],
      masterMenuId: json['masterMenuId'],
      menuName: json['menuName'],
      subMenuIcon: json['subMenuIcon'],
      subMenuName: json['subMenuName'],
      subMenuUrl: json['subMenuUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toIso8601String(),
      'createdBy': createdBy,
      'id': id,
      'isActive': isActive,
      'masterMenuId': masterMenuId,
      'menuName': menuName,
      'subMenuIcon': subMenuIcon,
      'subMenuName': subMenuName,
      'subMenuUrl': subMenuUrl,
    };
  }
}
