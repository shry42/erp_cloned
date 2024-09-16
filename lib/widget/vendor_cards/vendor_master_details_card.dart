import 'package:flutter/material.dart';

class VendorDetailsCard extends StatelessWidget {
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
  final String? bankIFSCCode;
  final String? bankBranch;
  final String? bankZipCode;
  final String? bankStreet;
  final String? bankCity;
  final String? bankState;

  const VendorDetailsCard({
    Key? key,
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
    this.bankIFSCCode,
    this.bankBranch,
    this.bankZipCode,
    this.bankStreet,
    this.bankCity,
    this.bankState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Table(
          defaultColumnWidth: const FixedColumnWidth(200.0),
          border: TableBorder.all(
            color: Colors.green[300]!,
            width: 2.0,
            borderRadius: BorderRadius.circular(12),
          ),
          children: [
            _buildTableRow('Name', '$vendorName'),
            _buildTableRow('Group', '$vendorGroup'),
            _buildTableRow('Payment Terms', '$paymentTerms'),
            _buildTableRow('Vendor Currency', '$vendorCurrency'),
            _buildTableRow('Telephone', '$telephone'),
            _buildTableRow('Mobile', '$mobilePhone'),
            _buildTableRow('Email', '$emailID'),
            _buildTableRow('Website', '$website'),
            _buildTableRow('Address Line 1', '$billToAddressL1'),
            _buildTableRow('Address Line 2', '$billToAddressL2'),
            _buildTableRow('Address Line 3', '$billToAddressL3'),
            _buildTableRow('Zip Code', '$billToZipCode'),
            _buildTableRow('City', '$billToCity'),
            _buildTableRow('State', '$billToState'),
            _buildTableRow('Country', '$billToCountry'),
            _buildTableRow('GST Number', '$gstNumber'),
            _buildTableRow('GST Type', '$gstRegType'),
            _buildTableRow('MSME Number', '$msme'),
            _buildTableRow('PAN Number', '$pan'),
            _buildTableRow('Bank Account Number', '$accountNo'),
            _buildTableRow('Account Name', '$accountName'),
            _buildTableRow('IFSC Code', '$bankIFSCCode'),
            _buildTableRow('Branch', '$bankBranch'),
            _buildTableRow('Street', '$bankStreet'),
            _buildTableRow('City', '$bankCity'),
            _buildTableRow('State', '$bankState'),
            _buildTableRow('Zip Code', '$bankZipCode'),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 60, 58, 58),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
