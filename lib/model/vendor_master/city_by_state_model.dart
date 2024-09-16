class GetCityByStateCodeModel {
  final String? name;
  final String? countryCode;
  final String? stateCode;
  final String? latitude;
  final String? longitude;

  GetCityByStateCodeModel({
    this.name,
    this.countryCode,
    this.stateCode,
    this.latitude,
    this.longitude,
  });

  factory GetCityByStateCodeModel.fromJson(Map<String, dynamic> json) {
    return GetCityByStateCodeModel(
      name: json['name'] as String?,
      countryCode: json['countryCode'] as String?,
      stateCode: json['stateCode'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'countryCode': countryCode,
      'stateCode': stateCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
