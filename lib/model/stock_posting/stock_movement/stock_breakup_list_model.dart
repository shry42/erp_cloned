class StockBreakupListModel {
  String? inventoryName;
  int? quantity;

  StockBreakupListModel({
    this.inventoryName,
    this.quantity,
  });

  // fromJson method to parse JSON data
  factory StockBreakupListModel.fromJson(Map<String, dynamic> json) {
    return StockBreakupListModel(
      inventoryName: json['InventoryName'] as String?,
      quantity: json['Quantity'] as int?,
    );
  }

  // Optional toJson method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'InventoryName': inventoryName,
      'Quantity': quantity,
    };
  }
}
