class GetPOGeneratedDataModel {
  final int potxnID;
  final String poCode;

  GetPOGeneratedDataModel({
    required this.potxnID,
    required this.poCode,
  });

  // Factory constructor to create an instance from a JSON map
  factory GetPOGeneratedDataModel.fromJson(Map<String, dynamic> json) {
    return GetPOGeneratedDataModel(
      potxnID: json['POTxnID'] as int,
      poCode: json['POCode'] as String,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'POTxnID': potxnID,
      'POCode': poCode,
    };
  }
}
