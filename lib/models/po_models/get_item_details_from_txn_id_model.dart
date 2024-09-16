class GetItemDetailsFromItemIdModel {
  final int? itemID;
  final String? sapID;
  final String? itemName;
  final String? casNo;
  final String? internalCode;
  final String? itemGroup;
  final String? category;
  final String? inventoryUOM;
  final String? purchaseUOM;
  final int? itemsPerPurchase;
  final String? salesUOM;
  final int? itemsPerSales;
  final bool? manageBatch;
  final bool? serialManagement;
  final bool? qaManagement;
  final String? valuationMethod;
  final bool? purchaseItem;
  final bool? salesItem;
  final bool? inventoryItem;
  final String? hsnCode;
  final int? threshold;
  final int? safetyStock;
  final int? isActive;
  final String? isBlockUnBlockAt;
  final String? isBlockUnBlockBy;
  final bool? isBlockUnblockStatus;
  final String? isBlockUnblockRemarks;
  final int? safetyStockCount;

  GetItemDetailsFromItemIdModel({
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

  factory GetItemDetailsFromItemIdModel.fromJson(Map<String, dynamic> json) {
    return GetItemDetailsFromItemIdModel(
      itemID: json['ItemID'],
      sapID: json['SAP_ID'],
      itemName: json['Item_Name'],
      casNo: json['CAS_No'],
      internalCode: json['Internal_Code'],
      itemGroup: json['Item_Group'],
      category: json['Category'],
      inventoryUOM: json['Inventory_UOM'],
      purchaseUOM: json['Purchase_UOM'],
      itemsPerPurchase: json['Items_per_Purchase'],
      salesUOM: json['Sales_UOM'],
      itemsPerSales: json['Items_per_Sales'],
      manageBatch: json['Manage_Batch'],
      serialManagement: json['Serial_Management'],
      qaManagement: json['QAManagement'],
      valuationMethod: json['Valuation_Method'],
      purchaseItem: json['Purchase_Item'],
      salesItem: json['Sales_Item'],
      inventoryItem: json['Inventory_Item'],
      hsnCode: json['HSN_Code'],
      threshold: json['Threshold'],
      safetyStock: json['SafetyStock'],
      isActive: json['isActive'],
      isBlockUnBlockAt: json['isBlockUnBlockAt'],
      isBlockUnBlockBy: json['isBlockUnBlockBy'].toString(),
      isBlockUnblockStatus: json['isBlockUnblockStatus'],
      isBlockUnblockRemarks: json['isBlockUnblockRemarks'],
      safetyStockCount: json['SafetyStockCount'],
    );
  }

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
