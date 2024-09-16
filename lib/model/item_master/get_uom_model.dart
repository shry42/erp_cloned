class GetUomModel {
  final int? id;
  final String? code;
  final String? description;
  final int? isActive;

  GetUomModel({
    this.id,
    this.code,
    this.description,
    this.isActive,
  });

  factory GetUomModel.fromJson(Map<String, dynamic> json) {
    return GetUomModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'isActive': isActive,
    };
  }
}
