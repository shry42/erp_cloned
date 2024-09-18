class GetEntryNumberModel {
  final int getEntryNumber;

  GetEntryNumberModel({
    required this.getEntryNumber,
  });

  // Factory constructor to create an instance from a JSON map
  factory GetEntryNumberModel.fromJson(Map<String, dynamic> json) {
    return GetEntryNumberModel(
      getEntryNumber: json['getEntryNumber'] as int,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'getEntryNumber': getEntryNumber,
    };
  }
}
