class GetIFSCModel {
  final String? iso3166;
  final String? swift;
  final String? branch;
  final bool? rtgs;
  final String? city;
  final String? micr;
  final String? contact;
  final String? district;
  final bool? upi;
  final bool? imps;
  final String? address;
  final String? state;
  final String? centre;
  final bool? neft;
  final String? bank;
  final String? bankCode;
  final String? ifsc;
  final String? zipCode;

  GetIFSCModel({
    this.iso3166,
    this.swift,
    this.branch,
    this.rtgs,
    this.city,
    this.micr,
    this.contact,
    this.district,
    this.upi,
    this.imps,
    this.address,
    this.state,
    this.centre,
    this.neft,
    this.bank,
    this.bankCode,
    this.ifsc,
    this.zipCode,
  });

  factory GetIFSCModel.fromJson(Map<String, dynamic> json) {
    return GetIFSCModel(
      iso3166: json['ISO3166'] as String?,
      swift: json['SWIFT'] as String?,
      branch: json['BRANCH'] as String?,
      rtgs: json['RTGS'] as bool?,
      city: json['CITY'] as String?,
      micr: json['MICR'] as String?,
      contact: json['CONTACT'] as String?,
      district: json['DISTRICT'] as String?,
      upi: json['UPI'] as bool?,
      imps: json['IMPS'] as bool?,
      address: json['ADDRESS'] as String?,
      state: json['STATE'] as String?,
      centre: json['CENTRE'] as String?,
      neft: json['NEFT'] as bool?,
      bank: json['BANK'] as String?,
      bankCode: json['BANKCODE'] as String?,
      ifsc: json['IFSC'] as String?,
      zipCode: json['zipCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ISO3166': iso3166,
      'SWIFT': swift,
      'BRANCH': branch,
      'RTGS': rtgs,
      'CITY': city,
      'MICR': micr,
      'CONTACT': contact,
      'DISTRICT': district,
      'UPI': upi,
      'IMPS': imps,
      'ADDRESS': address,
      'STATE': state,
      'CENTRE': centre,
      'NEFT': neft,
      'BANK': bank,
      'BANKCODE': bankCode,
      'IFSC': ifsc,
      'zipCode': zipCode,
    };
  }
}
