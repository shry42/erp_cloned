class BlockItemListModel {
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
  final String? safetyStock;
  final int? isActive;
  final DateTime? isBlockUnBlockAt;
  final int? isBlockUnBlockBy;
  final String? isBlockUnblockStatus;
  final String? isBlockUnblockRemarks;

  BlockItemListModel({
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
  });

  factory BlockItemListModel.fromJson(Map<String, dynamic> json) {
    return BlockItemListModel(
      itemID: json['ItemID'] as int?,
      sapID: json['SAP_ID']?.toString(),
      itemName: json['Item_Name']?.toString(),
      casNo: json['CAS_No']?.toString(),
      internalCode: json['Internal_Code']?.toString(),
      itemGroup: json['Item_Group']?.toString(),
      category: json['Category']?.toString(),
      inventoryUOM: json['Inventory_UOM']?.toString(),
      purchaseUOM: json['Purchase_UOM']?.toString(),
      itemsPerPurchase: json['Items_per_Purchase'] as int?,
      salesUOM: json['Sales_UOM']?.toString(),
      itemsPerSales: json['Items_per_Sales'] as int?,
      manageBatch: json['Manage_Batch'] as bool?,
      serialManagement: json['Serial_Management'] as bool?,
      qaManagement: json['QAManagement'] as bool?,
      valuationMethod: json['Valuation_Method']?.toString(),
      purchaseItem: json['Purchase_Item'] as bool?,
      salesItem: json['Sales_Item'] as bool?,
      inventoryItem: json['Inventory_Item'] as bool?,
      hsnCode: json['HSN_Code']?.toString(),
      threshold: json['Threshold'] as int?,
      safetyStock: json['SafetyStock']?.toString(),
      isActive: json['isActive'] as int?,
      isBlockUnBlockAt: json['isBlockUnBlockAt'] != null
          ? DateTime.parse(json['isBlockUnBlockAt'])
          : null,
      isBlockUnBlockBy: json['isBlockUnBlockBy'] as int?,
      isBlockUnblockStatus: json['isBlockUnblockStatus']?.toString(),
      isBlockUnblockRemarks: json['isBlockUnblockRemarks']?.toString(),
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
      'isBlockUnBlockAt': isBlockUnBlockAt?.toIso8601String(),
      'isBlockUnBlockBy': isBlockUnBlockBy,
      'isBlockUnblockStatus': isBlockUnblockStatus,
      'isBlockUnblockRemarks': isBlockUnblockRemarks,
    };
  }
}
