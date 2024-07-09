class VendorDetailsModel {
  final String? POTxnID;
  final String? POCode;
  final String? PODate;
  final String? PRTxnID;
  final String? VendorID;
  final String? SupplierQuoteNo;
  final String? QuoteDate;
  final String? BuyerName;
  final String? BuyerEmailID;
  final String? BuyerTel;
  final String? BuyerMob;
  final String? SupplierPOCName;
  final String? SupplierPOCEmailID;
  final String? SupplierPOCTel;
  final String? SupplierPOCMob;
  final String? DeliveryTerms;
  final String? PaymentTerms;
  final String? HeaderNote;
  final String? ApprovalStatus;
  final String? POFulfillmentLevel;
  final String? POStatus;
  final String? RevisionNumber;
  final String? FinancialYear;
  final String? ApprovedON;
  final String? ApprovedBy;
  final String? VendorName;
  final String? VendorGroup;
  final String? VendorCurrency;
  final String? Telephone;
  final String? MobilePhone;
  final String? EmailID;
  final String? Website;
  final String? BillToAddressL1;
  final String? BillToAddressL2;
  final String? BillToAddressL3;
  final String? BillToZipCode;
  final String? BillToCity;
  final String? BillToState;
  final String? BillToCountry;
  final String? GSTNumber;
  final String? GSTRegType;
  final String? MSME;
  final String? PAN;
  final String? AccountNo;
  final String? AccountName;
  final String? BankBranch;
  final String? BankIFSCCode;
  final String? BankZipCode;
  final String? BankStreet;
  final String? BankCity;
  final String? BankState;
  final String? VCTxnID;

  VendorDetailsModel(
      {this.POTxnID,
      this.POCode,
      this.PODate,
      this.PRTxnID,
      this.VendorID,
      this.SupplierQuoteNo,
      this.QuoteDate,
      this.BuyerName,
      this.BuyerEmailID,
      this.BuyerTel,
      this.BuyerMob,
      this.SupplierPOCName,
      this.SupplierPOCEmailID,
      this.SupplierPOCTel,
      this.SupplierPOCMob,
      this.DeliveryTerms,
      this.PaymentTerms,
      this.HeaderNote,
      this.ApprovalStatus,
      this.POFulfillmentLevel,
      this.POStatus,
      this.RevisionNumber,
      this.FinancialYear,
      this.ApprovedON,
      this.ApprovedBy,
      this.VendorName,
      this.VendorGroup,
      this.VendorCurrency,
      this.Telephone,
      this.MobilePhone,
      this.EmailID,
      this.Website,
      this.BillToAddressL1,
      this.BillToAddressL2,
      this.BillToAddressL3,
      this.BillToZipCode,
      this.BillToCity,
      this.BillToState,
      this.BillToCountry,
      this.GSTNumber,
      this.GSTRegType,
      this.MSME,
      this.PAN,
      this.AccountNo,
      this.AccountName,
      this.BankBranch,
      this.BankIFSCCode,
      this.BankZipCode,
      this.BankStreet,
      this.BankCity,
      this.BankState,
      this.VCTxnID});

  factory VendorDetailsModel.fromJson(Map<String, dynamic> json) {
    return VendorDetailsModel(
        POTxnID: json['POTxnID'].toString(),
        POCode: json['POCode'].toString(),
        PODate: json['PODate'].toString(),
        PRTxnID: json['PRTxnID'].toString(),
        VendorID: json['VendorID'].toString(),
        SupplierQuoteNo: json['SupplierQuoteNo'].toString(),
        QuoteDate: json['QuoteDate'].toString(),
        BuyerName: json['BuyerName'].toString(),
        BuyerEmailID: json['BuyerEmailID'].toString(),
        BuyerTel: json['BuyerTel '].toString(),
        BuyerMob: json['BuyerMob'].toString(),
        SupplierPOCName: json['SupplierPOCName'].toString(),
        SupplierPOCEmailID: json['SupplierPOCEmailID'].toString(),
        SupplierPOCTel: json['SupplierPOCTel '].toString(),
        SupplierPOCMob: json['SupplierPOCMob'].toString(),
        DeliveryTerms: json['DeliveryTerms'].toString(),
        PaymentTerms: json['PaymentTerms'].toString(),
        HeaderNote: json['HeaderNote'].toString(),
        ApprovalStatus: json['ApprovalStatus '].toString(),
        POFulfillmentLevel: json['POFulfillmentLevel'].toString(),
        POStatus: json['POStatus'].toString(),
        RevisionNumber: json['RevisionNumber'].toString(),
        FinancialYear: json['FinancialYear'].toString(),
        ApprovedON: json['ApprovedON'].toString(),
        ApprovedBy: json['ApprovedBy '].toString(),
        VendorName: json['VendorName'].toString(),
        VendorGroup: json['VendorGroup'].toString(),
        VendorCurrency: json['VendorCurrency'].toString(),
        Telephone: json['Telephone'].toString(),
        MobilePhone: json['MobilePhone'].toString(),
        EmailID: json['EmailID'].toString(),
        Website: json['Website '].toString(),
        BillToAddressL1: json['BillToAddressL1'].toString(),
        BillToAddressL2: json['BillToAddressL2'].toString(),
        BillToAddressL3: json['BillToAddressL3'].toString(),
        BillToZipCode: json['BillToZipCode'].toString(),
        BillToCity: json['BillToCity'].toString(),
        BillToState: json['BillToState'].toString(),
        BillToCountry: json['BillToCountry'].toString(),
        GSTNumber: json['GSTNumber'].toString(),
        GSTRegType: json['GSTRegType'].toString(),
        MSME: json['MSME'].toString(),
        PAN: json['PAN'].toString(),
        AccountNo: json['AccountNo '].toString(),
        AccountName: json['AccountName'].toString(),
        BankBranch: json['BankBranch'].toString(),
        BankIFSCCode: json['BankIFSCCode'].toString(),
        BankZipCode: json['BankZipCode'].toString(),
        BankStreet: json['BankStreet'].toString(),
        BankCity: json['BankCity '].toString(),
        BankState: json['BankState'].toString(),
        VCTxnID: json['VCTxnID'].toString());
  }
}
