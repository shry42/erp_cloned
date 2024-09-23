class NAStockListModel {
  final int itemID;
  final String itemName;
  final String batchNo;
  final String serialNo;
  final String internalCode;
  final String itemGroup;
  final String purchaseUOM;
  final int naStock;
  final DateTime postDate;
  final int id;
  final String sapID;

  NAStockListModel({
    required this.itemID,
    required this.itemName,
    required this.batchNo,
    required this.serialNo,
    required this.internalCode,
    required this.itemGroup,
    required this.purchaseUOM,
    required this.naStock,
    required this.postDate,
    required this.id,
    required this.sapID,
  });

  factory NAStockListModel.fromJson(Map<String, dynamic> json) {
    return NAStockListModel(
      itemID: json['ItemID'],
      itemName: json['ItemName'],
      batchNo: json['BatchNo'],
      serialNo: json['SerialNo'],
      internalCode: json['InternalCode'],
      itemGroup: json['ItemGroup'],
      purchaseUOM: json['PurchaseUOM'],
      naStock: json['NAStock'],
      postDate: DateTime.parse(json['PostDate']),
      id: json['id'],
      sapID: json['SAP_ID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemID,
      'ItemName': itemName,
      'BatchNo': batchNo,
      'SerialNo': serialNo,
      'InternalCode': internalCode,
      'ItemGroup': itemGroup,
      'PurchaseUOM': purchaseUOM,
      'NAStock': naStock,
      'PostDate': postDate.toIso8601String(),
      'id': id,
      'SAP_ID': sapID,
    };
  }
}
