class TaxListModel {
  final double? taxRate;
  final String? taxName;

  TaxListModel({
    this.taxRate,
    this.taxName,
  });

  factory TaxListModel.fromJson(Map<String, dynamic> json) {
    return TaxListModel(
      taxRate: json['TaxRate'] != null ? json['TaxRate'].toDouble() : null,
      taxName: json['TaxName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TaxRate': taxRate,
      'TaxName': taxName,
    };
  }
}
