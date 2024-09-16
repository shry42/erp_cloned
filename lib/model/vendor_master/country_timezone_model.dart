class Country {
  final String? name;
  final String? isoCode;
  final String? flag;
  final String? phonecode;
  final String? currency;
  final String? latitude;
  final String? longitude;
  final List<Timezone>? timezones;

  Country({
    this.name,
    this.isoCode,
    this.flag,
    this.phonecode,
    this.currency,
    this.latitude,
    this.longitude,
    this.timezones,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String?,
      isoCode: json['isoCode'] as String?,
      flag: json['flag'] as String?,
      phonecode: json['phonecode'] as String?,
      currency: json['currency'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      timezones: (json['timezones'] as List<dynamic>?)
          ?.map((e) => Timezone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isoCode': isoCode,
      'flag': flag,
      'phonecode': phonecode,
      'currency': currency,
      'latitude': latitude,
      'longitude': longitude,
      'timezones': timezones?.map((e) => e.toJson()).toList(),
    };
  }
}

class Timezone {
  final String? zoneName;
  final int? gmtOffset;
  final String? gmtOffsetName;
  final String? abbreviation;
  final String? tzName;

  Timezone({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      zoneName: json['zoneName'] as String?,
      gmtOffset: json['gmtOffset'] as int?,
      gmtOffsetName: json['gmtOffsetName'] as String?,
      abbreviation: json['abbreviation'] as String?,
      tzName: json['tzName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zoneName': zoneName,
      'gmtOffset': gmtOffset,
      'gmtOffsetName': gmtOffsetName,
      'abbreviation': abbreviation,
      'tzName': tzName,
    };
  }
}
