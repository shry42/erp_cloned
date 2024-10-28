class GetBlockedVendorListModel {
  int? vendorID;
  String? vendorName;
  String? vendorGroup;
  String? paymentTerms;
  String? vendorCurrency;
  String? telephone;
  String? mobilePhone;
  String? emailID;
  String? website;
  String? billToAddressL1;
  String? billToAddressL2;
  String? billToAddressL3;
  String? billToZipCode;
  String? billToCity;
  String? billToState;
  String? billToCountry;
  String? gstNumber;
  String? gstRegType;
  String? msme;
  String? pan;
  String? accountNo;
  String? accountName;
  String? bankBranch;
  String? bankIFSCCode;
  String? bankZipCode;
  String? bankStreet;
  String? bankCity;
  String? bankState;
  int? vcTxnID;
  int? isActive;
  DateTime? isBlockUnBlockAt;
  int? isBlockUnBlockBy;
  String? isBlockUnblockStatus;
  String? isBlockUnblockRemarks;

  GetBlockedVendorListModel({
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

  // Factory method to create an instance from JSON
  factory GetBlockedVendorListModel.fromJson(Map<String, dynamic> json) {
    return GetBlockedVendorListModel(
      vendorID: json['VendorID'] as int?,
      vendorName: json['VendorName'] as String?,
      vendorGroup: json['VendorGroup'] as String?,
      paymentTerms: json['PaymentTerms'] as String?,
      vendorCurrency: json['VendorCurrency'] as String?,
      telephone: json['Telephone'] as String?,
      mobilePhone: json['MobilePhone'] as String?,
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
      vcTxnID: json['VCTxnID'] as int?,
      isActive: json['isActive'] as int?,
      isBlockUnBlockAt: json['isBlockUnBlockAt'] != null
          ? DateTime.parse(json['isBlockUnBlockAt'] as String)
          : null,
      isBlockUnBlockBy: json['isBlockUnBlockBy'] as int?,
      isBlockUnblockStatus: json['isBlockUnblockStatus'] as String?,
      isBlockUnblockRemarks: json['isBlockUnblockRemarks'] as String?,
    );
  }

  // Method to convert the instance to JSON
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
      'isBlockUnBlockAt':
          isBlockUnBlockAt?.toIso8601String(), // Converts DateTime to String
      'isBlockUnBlockBy': isBlockUnBlockBy,
      'isBlockUnblockStatus': isBlockUnblockStatus,
      'isBlockUnblockRemarks': isBlockUnblockRemarks,
    };
  }
}
