class GRNRejectedListInsideModel {
  int? id;
  int? grnTxnID;
  int? itemID;
  int? qty;
  String? amount;
  String? amountWithTax;
  String? files;
  DateTime? createdAt;
  int? createdBy;
  bool? isActive;
  String? creditNoteDetails;
  String? grnRejectType;

  GRNRejectedListInsideModel({
    this.id,
    this.grnTxnID,
    this.itemID,
    this.qty,
    this.amount,
    this.amountWithTax,
    this.files,
    this.createdAt,
    this.createdBy,
    this.isActive,
    this.creditNoteDetails,
    this.grnRejectType,
  });

  // Factory method to create an instance from JSON
  factory GRNRejectedListInsideModel.fromJson(Map<String, dynamic> json) {
    return GRNRejectedListInsideModel(
      id: json['id'],
      grnTxnID: json['GRNTxnID'],
      itemID: json['ItemID'],
      qty: json['qty'],
      amount: json['amount'],
      amountWithTax: json['amountWithTax'],
      files: json['files'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      createdBy: json['createdBy'],
      isActive: json['isActive'] == 1 ? true : false,
      creditNoteDetails: json['creditNoteDetails'],
      grnRejectType: json['GRNRejectType'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'GRNTxnID': grnTxnID,
      'ItemID': itemID,
      'qty': qty,
      'amount': amount,
      'amountWithTax': amountWithTax,
      'files': files,
      'createdAt': createdAt?.toIso8601String(),
      'createdBy': createdBy,
      'isActive': isActive == true ? 1 : 0,
      'creditNoteDetails': creditNoteDetails,
      'GRNRejectType': grnRejectType,
    };
  }
}
