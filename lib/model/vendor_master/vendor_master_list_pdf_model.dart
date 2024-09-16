class VendorMasterListPdfModel {
  final String? storedFileName;
  final String? filePath;

  VendorMasterListPdfModel({
    this.storedFileName,
    this.filePath,
  });

  factory VendorMasterListPdfModel.fromJson(Map<String, dynamic> json) {
    return VendorMasterListPdfModel(
      storedFileName: json['StoredFileName'] as String?,
      filePath: json['FilePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StoredFileName': storedFileName,
      'FilePath': filePath,
    };
  }
}
