class StateByCountryCodeModel {
  final String? name;
  final String? isoCode;
  final String? countryCode;
  final String? latitude;
  final String? longitude;

  StateByCountryCodeModel({
    this.name,
    this.isoCode,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  factory StateByCountryCodeModel.fromJson(Map<String, dynamic> json) {
    return StateByCountryCodeModel(
      name: json['name'] as String?,
      isoCode: json['isoCode'] as String?,
      countryCode: json['countryCode'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isoCode': isoCode,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
