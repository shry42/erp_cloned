class GetVendorAllocationDetailsModel {
  int? id;
  int? vendorId;
  String? vendorName;
  int? createdBy;
  DateTime? createdAt;
  int? isActive;
  DateTime? date;

  GetVendorAllocationDetailsModel({
    this.id,
    this.vendorId,
    this.vendorName,
    this.createdBy,
    this.createdAt,
    this.isActive,
    this.date,
  });

  factory GetVendorAllocationDetailsModel.fromJson(Map<String, dynamic> json) {
    return GetVendorAllocationDetailsModel(
      id: json['id'],
      vendorId: json['vendorId'],
      vendorName: json['vendorName'],
      createdBy: json['createdBy'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      isActive: json['isActive'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'createdBy': createdBy,
      'createdAt': createdAt?.toIso8601String(),
      'isActive': isActive,
      'date': date?.toIso8601String(),
    };
  }

  // Function to get the date part only as String
  String? getCreatedAtDate() {
    return createdAt != null ? createdAt.toString().split('T')[0] : null;
  }

  String? getDateOnly() {
    return date != null ? date.toString().split('T')[0] : null;
  }
}
