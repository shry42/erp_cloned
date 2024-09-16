class VendorModel {
  final int? vendorID;
  final String? vendorName;
  final String? vendorGroup;
  final String? paymentTerms;
  final String? vendorCurrency;
  final String? telephone;
  final String? mobilePhone;
  final String? emailID;
  final String? website;
  final String? billToAddressL1;
  final String? billToAddressL2;
  final String? billToAddressL3;
  final String? billToZipCode;
  final String? billToCity;
  final String? billToState;
  final String? billToCountry;
  final String? gstNumber;
  final String? gstRegType;
  final String? msme;
  final String? pan;
  final String? accountNo;
  final String? accountName;
  final String? bankBranch;
  final String? bankIFSCCode;
  final String? bankZipCode;
  final String? bankStreet;
  final String? bankCity;
  final String? bankState;
  final String? vcTxnID;
  final int? isActive;
  final DateTime? isBlockUnBlockAt;
  final int? isBlockUnBlockBy;
  final String? isBlockUnblockStatus;
  final String? isBlockUnblockRemarks;

  VendorModel({
    this.vendorID,
    this.vendorName,
    this.vendorGroup,
    this.paymentTerms,
    this.vendorCurrency,
    this.telephone,
    this.mobilePhone,
    this.emailID,
    this.website,
    this.billToAddressL1,
    this.billToAddressL2,
    this.billToAddressL3,
    this.billToZipCode,
    this.billToCity,
    this.billToState,
    this.billToCountry,
    this.gstNumber,
    this.gstRegType,
    this.msme,
    this.pan,
    this.accountNo,
    this.accountName,
    this.bankBranch,
    this.bankIFSCCode,
    this.bankZipCode,
    this.bankStreet,
    this.bankCity,
    this.bankState,
    this.vcTxnID,
    this.isActive,
    this.isBlockUnBlockAt,
    this.isBlockUnBlockBy,
    this.isBlockUnblockStatus,
    this.isBlockUnblockRemarks,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      vendorID: json['VendorID'] as int?,
      vendorName: json['VendorName'] as String?,
      vendorGroup: json['VendorGroup'] as String?,
      paymentTerms: json['PaymentTerms'] as String?,
      vendorCurrency: json['VendorCurrency'] as String?,
      telephone: json['Telephone'] as String?,
      mobilePhone:
          json['MobilePhone']?.toString(), // Handle int to String conversion
      emailID: json['EmailID'] as String?,
      website: json['Website'] as String?,
      billToAddressL1: json['BillToAddressL1'] as String?,
      billToAddressL2: json['BillToAddressL2'] as String?,
      billToAddressL3: json['BillToAddressL3'] as String?,
      billToZipCode: json['BillToZipCode'] as String?,
      billToCity: json['BillToCity'] as String?,
      billToState: json['BillToState'] as String?,
      billToCountry: json['BillToCountry'] as String?,
      gstNumber: json['GSTNumber'] as String?,
      gstRegType: json['GSTRegType'] as String?,
      msme: json['MSME'] as String?,
      pan: json['PAN'] as String?,
      accountNo: json['AccountNo'] as String?,
      accountName: json['AccountName'] as String?,
      bankBranch: json['BankBranch'] as String?,
      bankIFSCCode: json['BankIFSCCode'] as String?,
      bankZipCode: json['BankZipCode'] as String?,
      bankStreet: json['BankStreet'] as String?,
      bankCity: json['BankCity'] as String?,
      bankState: json['BankState'] as String?,
      vcTxnID: json['VCTxnID']?.toString(), // Handle int to String conversion
      isActive: json['isActive'] as int?,
      isBlockUnBlockAt: json['isBlockUnBlockAt'] != null
          ? DateTime.parse(json['isBlockUnBlockAt'])
          : null,
      isBlockUnBlockBy: json['isBlockUnBlockBy'] as int?,
      isBlockUnblockStatus: json['isBlockUnblockStatus'] as String?,
      isBlockUnblockRemarks: json['isBlockUnblockRemarks'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'VendorID': vendorID,
      'VendorName': vendorName,
      'VendorGroup': vendorGroup,
      'PaymentTerms': paymentTerms,
      'VendorCurrency': vendorCurrency,
      'Telephone': telephone,
      'MobilePhone': mobilePhone,
      'EmailID': emailID,
      'Website': website,
      'BillToAddressL1': billToAddressL1,
      'BillToAddressL2': billToAddressL2,
      'BillToAddressL3': billToAddressL3,
      'BillToZipCode': billToZipCode,
      'BillToCity': billToCity,
      'BillToState': billToState,
      'BillToCountry': billToCountry,
      'GSTNumber': gstNumber,
      'GSTRegType': gstRegType,
      'MSME': msme,
      'PAN': pan,
      'AccountNo': accountNo,
      'AccountName': accountName,
      'BankBranch': bankBranch,
      'BankIFSCCode': bankIFSCCode,
      'BankZipCode': bankZipCode,
      'BankStreet': bankStreet,
      'BankCity': bankCity,
      'BankState': bankState,
      'VCTxnID': vcTxnID,
      'isActive': isActive,
      'isBlockUnBlockAt': isBlockUnBlockAt?.toIso8601String(),
      'isBlockUnBlockBy': isBlockUnBlockBy,
      'isBlockUnblockStatus': isBlockUnblockStatus,
      'isBlockUnblockRemarks': isBlockUnblockRemarks,
    };
  }
}
