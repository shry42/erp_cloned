class ItemModel {
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
  final DateTime? isBlockUnBlockAt;
  final int? isBlockUnBlockBy;
  final String? isBlockUnblockStatus;
  final String? isBlockUnblockRemarks;

  ItemModel({
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

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemID: json['ItemID'] != null ? (json['ItemID'] as num).toInt() : null,
      sapID: json['SAP_ID'] as String?,
      itemName: json['Item_Name'] as String?,
      casNo: json['CAS_No'] as String?,
      internalCode: json['Internal_Code'] as String?,
      itemGroup: json['Item_Group'] as String?,
      category: json['Category'] as String?,
      inventoryUOM: json['Inventory_UOM'] as String?,
      purchaseUOM: json['Purchase_UOM'] as String?,
      itemsPerPurchase: json['Items_per_Purchase'] != null
          ? (json['Items_per_Purchase'] as num).toInt()
          : null,
      salesUOM: json['Sales_UOM'] as String?,
      itemsPerSales: json['Items_per_Sales'] != null
          ? (json['Items_per_Sales'] as num).toInt()
          : null,
      manageBatch: json['Manage_Batch'] as bool?,
      serialManagement: json['Serial_Management'] as bool?,
      qaManagement: json['QAManagement'] as bool?,
      valuationMethod: json['Valuation_Method'] as String?,
      purchaseItem: json['Purchase_Item'] as bool?,
      salesItem: json['Sales_Item'] as bool?,
      inventoryItem: json['Inventory_Item'] as bool?,
      hsnCode: json['HSN_Code'] as String?,
      threshold:
          json['Threshold'] != null ? (json['Threshold'] as num).toInt() : null,
      safetyStock: json['SafetyStock'] != null
          ? (json['SafetyStock'] as num).toInt()
          : null,
      isActive:
          json['isActive'] != null ? (json['isActive'] as num).toInt() : null,
      isBlockUnBlockAt: json['isBlockUnBlockAt'] != null
          ? DateTime.parse(json['isBlockUnBlockAt'])
          : null,
      isBlockUnBlockBy: json['isBlockUnBlockBy'] != null
          ? (json['isBlockUnBlockBy'] as num).toInt()
          : null,
      isBlockUnblockStatus: json['isBlockUnblockStatus'] as String?,
      isBlockUnblockRemarks: json['isBlockUnblockRemarks'] as String?,
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
