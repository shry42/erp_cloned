class ItemDetailsFromStockBrkpModel {
  int? itemID;
  String? sapID;
  String? itemName;
  String? casNo;
  String? internalCode;
  String? itemGroup;
  String? category;
  String? inventoryUOM;
  String? purchaseUOM;
  int? itemsPerPurchase;
  String? salesUOM;
  int? itemsPerSales;
  bool? manageBatch;
  bool? serialManagement;
  bool? qaManagement;
  String? valuationMethod;
  bool? purchaseItem;
  bool? salesItem;
  bool? inventoryItem;
  String? hsnCode;
  int? threshold;
  int? safetyStock;
  int? isActive;
  String? isBlockUnBlockAt;
  int? isBlockUnBlockBy;
  String? isBlockUnblockStatus;
  String? isBlockUnblockRemarks;
  double? safetyStockCount;

  ItemDetailsFromStockBrkpModel({
    this.itemID,
    this.sapID,
    this.itemName,
    this.casNo,
    this.internalCode,
    this.itemGroup,
    this.category,
    this.inventoryUOM,
    this.purchaseUOM,
    this.itemsPerPurchase,
    this.salesUOM,
    this.itemsPerSales,
    this.manageBatch,
    this.serialManagement,
    this.qaManagement,
    this.valuationMethod,
    this.purchaseItem,
    this.salesItem,
    this.inventoryItem,
    this.hsnCode,
    this.threshold,
    this.safetyStock,
    this.isActive,
    this.isBlockUnBlockAt,
    this.isBlockUnBlockBy,
    this.isBlockUnblockStatus,
    this.isBlockUnblockRemarks,
    this.safetyStockCount,
  });

  factory ItemDetailsFromStockBrkpModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailsFromStockBrkpModel(
      itemID: json['ItemID'] as int?,
      sapID: json['SAP_ID'] as String?,
      itemName: json['Item_Name'] as String?,
      casNo: json['CAS_No'] as String?,
      internalCode: json['Internal_Code'] as String?,
      itemGroup: json['Item_Group'] as String?,
      category: json['Category'] as String?,
      inventoryUOM: json['Inventory_UOM'] as String?,
      purchaseUOM: json['Purchase_UOM'] as String?,
      itemsPerPurchase: json['Items_per_Purchase'] as int?,
      salesUOM: json['Sales_UOM'] as String?,
      itemsPerSales: json['Items_per_Sales'] as int?,
      manageBatch: json['Manage_Batch'] as bool?,
      serialManagement: json['Serial_Management'] as bool?,
      qaManagement: json['QAManagement'] as bool?,
      valuationMethod: json['Valuation_Method'] as String?,
      purchaseItem: json['Purchase_Item'] as bool?,
      salesItem: json['Sales_Item'] as bool?,
      inventoryItem: json['Inventory_Item'] as bool?,
      hsnCode: json['HSN_Code'] as String?,
      threshold: json['Threshold'] as int?,
      safetyStock: json['SafetyStock'] as int?,
      isActive: json['isActive'] as int?,
      isBlockUnBlockAt: json['isBlockUnBlockAt'] as String?,
      isBlockUnBlockBy: json['isBlockUnBlockBy'] as int?,
      isBlockUnblockStatus: json['isBlockUnblockStatus'] as String?,
      isBlockUnblockRemarks: json['isBlockUnblockRemarks'] as String?,
      safetyStockCount: (json['SafetyStockCount'] as num?)?.toDouble(),
    );
  }

  // Optional toJson method to convert model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'ItemID': itemID,
      'SAP_ID': sapID,
      'Item_Name': itemName,
      'CAS_No': casNo,
      'Internal_Code': internalCode,
      'Item_Group': itemGroup,
      'Category': category,
      'Inventory_UOM': inventoryUOM,
      'Purchase_UOM': purchaseUOM,
      'Items_per_Purchase': itemsPerPurchase,
      'Sales_UOM': salesUOM,
      'Items_per_Sales': itemsPerSales,
      'Manage_Batch': manageBatch,
      'Serial_Management': serialManagement,
      'QAManagement': qaManagement,
      'Valuation_Method': valuationMethod,
      'Purchase_Item': purchaseItem,
      'Sales_Item': salesItem,
      'Inventory_Item': inventoryItem,
      'HSN_Code': hsnCode,
      'Threshold': threshold,
      'SafetyStock': safetyStock,
      'isActive': isActive,
      'isBlockUnBlockAt': isBlockUnBlockAt,
      'isBlockUnBlockBy': isBlockUnBlockBy,
      'isBlockUnblockStatus': isBlockUnblockStatus,
      'isBlockUnblockRemarks': isBlockUnblockRemarks,
      'SafetyStockCount': safetyStockCount,
    };
  }
}
