class PaymentTermsModel {
  final int? ptid;
  final String? terms;

  PaymentTermsModel({
    this.ptid,
    this.terms,
  });

  // Factory method to create an instance of PaymentTermsModel from a JSON map
  factory PaymentTermsModel.fromJson(Map<String, dynamic> json) {
    return PaymentTermsModel(
      ptid: json['PTID'],
      terms: json['Terms'],
    );
  }
}
