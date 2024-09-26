class GetItemFromProjectCodeModel {
  final int itemId;
  final String internalCode;
  final int itemsPerPurchase;
  final String sapId;

  GetItemFromProjectCodeModel({
    required this.itemId,
    required this.internalCode,
    required this.itemsPerPurchase,
    required this.sapId,
  });

  // Factory method to create an instance from a JSON map
  factory GetItemFromProjectCodeModel.fromJson(Map<String, dynamic> json) {
    return GetItemFromProjectCodeModel(
      itemId: json['ItemID'],
      internalCode: json['InternalCode'],
      itemsPerPurchase: json['Items_per_Purchase'],
      sapId: json['SAP_ID'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemId,
      'InternalCode': internalCode,
      'Items_per_Purchase': itemsPerPurchase,
      'SAP_ID': sapId,
    };
  }
}
