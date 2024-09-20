class GRNAcceptanceModel {
  final int grnTxnID;
  final DateTime txnDate;
  final int userID;
  final String username;

  GRNAcceptanceModel({
    required this.grnTxnID,
    required this.txnDate,
    required this.userID,
    required this.username,
  });

  // Factory method to create an instance from JSON
  factory GRNAcceptanceModel.fromJson(Map<String, dynamic> json) {
    return GRNAcceptanceModel(
      grnTxnID: json['GRNTxnID'],
      txnDate: DateTime.parse(json['TxnDate']),
      userID: json['UserID'],
      username: json['Username'],
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'GRNTxnID': grnTxnID,
      'TxnDate': txnDate.toIso8601String(),
      'UserID': userID,
      'Username': username,
    };
  }
}
