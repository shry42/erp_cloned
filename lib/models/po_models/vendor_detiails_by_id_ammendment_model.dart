class VendorDetailsByIdAmendmentModel {
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
  final int? vcTxnID;
  final int? isActive;
  final dynamic isBlockUnBlockAt;
  final dynamic isBlockUnBlockBy;
  final dynamic isBlockUnblockStatus;
  final dynamic isBlockUnblockRemarks;

  VendorDetailsByIdAmendmentModel({
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

  // fromJson method to handle null and empty values
  factory VendorDetailsByIdAmendmentModel.fromJson(Map<String, dynamic> json) {
    return VendorDetailsByIdAmendmentModel(
      vendorID: json['VendorID'] != null ? json['VendorID'] as int : null,
      vendorName: json['VendorName'] != null && json['VendorName'].isNotEmpty
          ? json['VendorName'] as String
          : null,
      vendorGroup: json['VendorGroup'] != null && json['VendorGroup'].isNotEmpty
          ? json['VendorGroup'] as String
          : null,
      paymentTerms:
          json['PaymentTerms'] != null && json['PaymentTerms'].isNotEmpty
              ? json['PaymentTerms'] as String
              : null,
      vendorCurrency:
          json['VendorCurrency'] != null && json['VendorCurrency'].isNotEmpty
              ? json['VendorCurrency'] as String
              : null,
      telephone: json['Telephone'] != null && json['Telephone'].isNotEmpty
          ? json['Telephone'] as String
          : null,
      mobilePhone: json['MobilePhone'] != null && json['MobilePhone'].isNotEmpty
          ? json['MobilePhone'] as String
          : null,
      emailID: json['EmailID'] != null && json['EmailID'].isNotEmpty
          ? json['EmailID'] as String
          : null,
      website: json['Website'] != null && json['Website'].isNotEmpty
          ? json['Website'] as String
          : null,
      billToAddressL1:
          json['BillToAddressL1'] != null && json['BillToAddressL1'].isNotEmpty
              ? json['BillToAddressL1'] as String
              : null,
      billToAddressL2:
          json['BillToAddressL2'] != null && json['BillToAddressL2'].isNotEmpty
              ? json['BillToAddressL2'] as String
              : null,
      billToAddressL3:
          json['BillToAddressL3'] != null && json['BillToAddressL3'].isNotEmpty
              ? json['BillToAddressL3'] as String
              : null,
      billToZipCode:
          json['BillToZipCode'] != null && json['BillToZipCode'].isNotEmpty
              ? json['BillToZipCode'] as String
              : null,
      billToCity: json['BillToCity'] != null && json['BillToCity'].isNotEmpty
          ? json['BillToCity'] as String
          : null,
      billToState: json['BillToState'] != null && json['BillToState'].isNotEmpty
          ? json['BillToState'] as String
          : null,
      billToCountry:
          json['BillToCountry'] != null && json['BillToCountry'].isNotEmpty
              ? json['BillToCountry'] as String
              : null,
      gstNumber: json['GSTNumber'] != null && json['GSTNumber'].isNotEmpty
          ? json['GSTNumber'] as String
          : null,
      gstRegType: json['GSTRegType'] != null && json['GSTRegType'].isNotEmpty
          ? json['GSTRegType'] as String
          : null,
      msme: json['MSME'] != null && json['MSME'].isNotEmpty
          ? json['MSME'] as String
          : null,
      pan: json['PAN'] != null && json['PAN'].isNotEmpty
          ? json['PAN'] as String
          : null,
      accountNo: json['AccountNo'] != null && json['AccountNo'].isNotEmpty
          ? json['AccountNo'] as String
          : null,
      accountName: json['AccountName'] != null && json['AccountName'].isNotEmpty
          ? json['AccountName'] as String
          : null,
      bankBranch: json['BankBranch'] != null && json['BankBranch'].isNotEmpty
          ? json['BankBranch'] as String
          : null,
      bankIFSCCode:
          json['BankIFSCCode'] != null && json['BankIFSCCode'].isNotEmpty
              ? json['BankIFSCCode'] as String
              : null,
      bankZipCode: json['BankZipCode'] != null && json['BankZipCode'].isNotEmpty
          ? json['BankZipCode'] as String
          : null,
      bankStreet: json['BankStreet'] != null && json['BankStreet'].isNotEmpty
          ? json['BankStreet'] as String
          : null,
      bankCity: json['BankCity'] != null && json['BankCity'].isNotEmpty
          ? json['BankCity'] as String
          : null,
      bankState: json['BankState'] != null && json['BankState'].isNotEmpty
          ? json['BankState'] as String
          : null,
      vcTxnID: json['VCTxnID'] != null ? json['VCTxnID'] as int : null,
      isActive: json['isActive'] != null ? json['isActive'] as int : null,
      isBlockUnBlockAt: json['isBlockUnBlockAt'],
      isBlockUnBlockBy: json['isBlockUnBlockBy'],
      isBlockUnblockStatus: json['isBlockUnblockStatus'],
      isBlockUnblockRemarks: json['isBlockUnblockRemarks'],
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
      'isBlockUnBlockAt': isBlockUnBlockAt,
      'isBlockUnBlockBy': isBlockUnBlockBy,
      'isBlockUnblockStatus': isBlockUnblockStatus,
      'isBlockUnblockRemarks': isBlockUnblockRemarks,
    };
  }
}
