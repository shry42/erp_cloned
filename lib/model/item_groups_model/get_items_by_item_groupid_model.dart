class GetItemsByItemGroupIdModel {
  String? itemName;
  int? itemID;

  GetItemsByItemGroupIdModel({
    this.itemName,
    this.itemID,
  });

  // Factory method to create an instance from JSON
  factory GetItemsByItemGroupIdModel.fromJson(Map<String, dynamic> json) {
    return GetItemsByItemGroupIdModel(
      itemName: json['Item_Name'] as String?,
      itemID: json['ItemID'] as int?,
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'Item_Name': itemName,
      'ItemID': itemID,
    };
  }
}
