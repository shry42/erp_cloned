class PendingVendorModel {
  int? vCTxnID;
  DateTime? vCTxnDate;
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
  bool? approvalStatus;
  bool? rejected;

  PendingVendorModel({
    this.vCTxnID,
    this.vCTxnDate,
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
    this.approvalStatus,
    this.rejected,
  });

  factory PendingVendorModel.fromJson(Map<String, dynamic> json) {
    return PendingVendorModel(
      vCTxnID: json['VCTxnID'],
      vCTxnDate:
          json['VCTxnDate'] != null ? DateTime.parse(json['VCTxnDate']) : null,
      vendorName: json['VendorName'],
      vendorGroup: json['VendorGroup'],
      paymentTerms: json['PaymentTerms'],
      vendorCurrency: json['VendorCurrency'],
      telephone: json['Telephone'],
      mobilePhone: json['MobilePhone'],
      emailID: json['EmailID'],
      website: json['Website'],
      billToAddressL1: json['BillToAddressL1'],
      billToAddressL2: json['BillToAddressL2'],
      billToAddressL3: json['BillToAddressL3'],
      billToZipCode: json['BillToZipCode'],
      billToCity: json['BillToCity'],
      billToState: json['BillToState'],
      billToCountry: json['BillToCountry'],
      gstNumber: json['GSTNumber'],
      gstRegType: json['GSTRegType'],
      msme: json['MSME'],
      pan: json['PAN'],
      accountNo: json['AccountNo'],
      accountName: json['AccountName'],
      bankBranch: json['BankBranch'],
      bankIFSCCode: json['BankIFSCCode'],
      bankZipCode: json['BankZipCode'],
      bankStreet: json['BankStreet'],
      bankCity: json['BankCity'],
      bankState: json['BankState'],
      approvalStatus: json['ApprovalStatus'],
      rejected: json['Rejected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'VCTxnID': vCTxnID,
      'VCTxnDate': vCTxnDate?.toIso8601String(),
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
      'ApprovalStatus': approvalStatus,
      'Rejected': rejected,
    };
  }
}
