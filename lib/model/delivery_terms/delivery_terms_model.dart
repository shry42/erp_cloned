class DeliveryTermsModel {
  final int? dtid;
  final String? terms;

  DeliveryTermsModel({
    this.dtid,
    this.terms,
  });

  // Factory method to create an instance of PaymentTermsModel from a JSON map
  factory DeliveryTermsModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTermsModel(
      dtid: json['DTID'],
      terms: json['Terms'],
    );
  }
}
