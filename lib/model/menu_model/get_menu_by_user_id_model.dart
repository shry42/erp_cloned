class GetMenuByUserIdModel {
  String? menuName;
  String? subMenuName;
  int? menuId;
  int? subMenuId;
  int? id;
  String? subMenuUrl;
  String? subMenuIcon;

  GetMenuByUserIdModel({
    this.menuName,
    this.subMenuName,
    this.menuId,
    this.subMenuId,
    this.id,
    this.subMenuUrl,
    this.subMenuIcon,
  });

  // Factory constructor for creating a new GetMenuByUserIdModel instance from a map
  factory GetMenuByUserIdModel.fromJson(Map<String, dynamic> json) {
    return GetMenuByUserIdModel(
      menuName: json['menuName'] as String?,
      subMenuName: json['subMenuName'] as String?,
      menuId: json['menuId'] as int?,
      subMenuId: json['subMenuId'] as int?,
      id: json['id'] as int?,
      subMenuUrl: json['subMenuUrl'] as String?,
      subMenuIcon: json['subMenuIcon'] as String?,
    );
  }

  // Method to convert GetMenuByUserIdModel instance to a map
  Map<String, dynamic> toJson() {
    return {
      'menuName': menuName,
      'subMenuName': subMenuName,
      'menuId': menuId,
      'subMenuId': subMenuId,
      'id': id,
      'subMenuUrl': subMenuUrl,
      'subMenuIcon': subMenuIcon,
    };
  }
}
