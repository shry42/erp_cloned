class ItemBlockUnblockLogModel {
  final int? id;
  final int? itemId;
  final String? isBlockUnBlockAt;
  final int? isBlockUnBlockBy;
  final String? status;
  final int? isActive;
  final String? isBlockUnblockRemarks;
  final String? superadminStatus;
  final String? venusId;
  final String? itemGroup;
  final String? itemName;

  ItemBlockUnblockLogModel({
    this.id,
    this.itemId,
    this.isBlockUnBlockAt,
    this.isBlockUnBlockBy,
    this.status,
    this.isActive,
    this.isBlockUnblockRemarks,
    this.superadminStatus,
    this.venusId,
    this.itemGroup,
    this.itemName,
  });

  factory ItemBlockUnblockLogModel.fromJson(Map<String, dynamic> json) {
    return ItemBlockUnblockLogModel(
      id: json['id'] as int?,
      itemId: json['itemId'] as int?,
      isBlockUnBlockAt: json['isBlockUnBlockAt'] as String?,
      isBlockUnBlockBy: json['isBlockUnBlockBy'] as int?,
      status: json['status'] as String?,
      isActive: json['isActive'] as int?,
      isBlockUnblockRemarks: json['isBlockUnblockRemarks'] as String?,
      superadminStatus: json['superadminStatus'] as String?,
      venusId: json['venusId'] as String?,
      itemGroup: json['itemGroup'] as String?,
      itemName: json['itemName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemId': itemId,
      'isBlockUnBlockAt': isBlockUnBlockAt,
      'isBlockUnBlockBy': isBlockUnBlockBy,
      'status': status,
      'isActive': isActive,
      'isBlockUnblockRemarks': isBlockUnblockRemarks,
      'superadminStatus': superadminStatus,
      'venusId': venusId,
      'itemGroup': itemGroup,
      'itemName': itemName,
    };
  }
}
