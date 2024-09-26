class UOMDataModel {
  int? id;
  String? code;
  String? description;
  int? isActive;

  UOMDataModel({
    this.id,
    this.code,
    this.description,
    this.isActive,
  });

  // Factory method to create UOMDataModel from JSON
  factory UOMDataModel.fromJson(Map<String, dynamic> json) {
    return UOMDataModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as int?,
    );
  }

  // Method to convert UOMDataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'isActive': isActive,
    };
  }
}
