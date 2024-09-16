import 'package:flutter/material.dart';

class VendorDetailsCard extends StatelessWidget {
  VendorDetailsCard({
    super.key,
    this.POTxnID,
    this.POCode,
    this.PODate,
    this.RevisionNumber,
    this.PANNo,
    this.VendorID,
    this.VendorName,
    this.VendorGroup,
    this.VendorCurrency,
    this.BillToAddressL1,
    this.BillToAddressL2,
    this.BillToAddressL3,
    this.BillToState,
    this.BillToCountry,
    this.BillToCity,
    this.BillToZipCode,
    this.GSTNumber,
    this.GSTRegType,
    this.MSME,
    this.EmailId,
    this.Telephone,
    this.MobilePhone,
    this.Website,
    this.DeliveryTerms,
    this.PaymentTerms,
    this.HeaderNote,
    this.HSNCode,
    this.POQuantity,
    this.PurchaseUOM,
    this.DeliveryDate,
    this.UnitPrice,
    this.TaxCode,
    this.TaxAmount,
    this.TaxPercent,
    this.LineTotal,
    this.FinalAmount,
  });

  final String? POTxnID;
  final String? POCode;
  final String? PODate;
  final String? RevisionNumber;
  final String? PANNo;
  final String? VendorID;
  final String? VendorName;
  final String? VendorGroup;
  final String? VendorCurrency;
  final String? BillToAddressL1;
  final String? BillToAddressL2;
  final String? BillToAddressL3;
  final String? BillToState;
  final String? BillToCountry;
  final String? BillToCity;
  final String? BillToZipCode;
  final String? GSTNumber;
  final String? GSTRegType;
  final String? MSME;
  final String? EmailId;
  final String? Telephone;
  final String? MobilePhone;
  final String? Website;
  final String? DeliveryTerms;
  final String? PaymentTerms;
  final String? HeaderNote;
  final String? HSNCode;
  final String? POQuantity;
  final String? PurchaseUOM;
  final String? DeliveryDate;
  final String? UnitPrice;
  final String? TaxCode;
  final String? TaxAmount;
  final String? TaxPercent;
  final String? LineTotal;
  final String? FinalAmount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(200.0),
              border: TableBorder.all(
                color: Colors.green[300]!,
                width: 2.0,
                borderRadius: BorderRadius.circular(12),
              ),
              children: [
                _buildTableRow('POTxnID', '$POTxnID', isFirstRow: true),
                _buildTableRow('PO Code', '$POCode'),
                _buildTableRow('PO Date', '$PODate'),
                _buildTableRow('Revision Number', '$RevisionNumber'),
                _buildTableRow('PAN No', '$PANNo'),
                _buildTableRow('Vendor ID', '$VendorID'),
                _buildTableRow('Vendor Name', '$VendorName'),
                _buildTableRow('Vendor Group', '$VendorGroup'),
                _buildTableRow('Vendor Currency', '$VendorCurrency'),
                _buildTableRow('BillToAddressL1', '$BillToAddressL1'),
                _buildTableRow('BillToAddressL2', '$BillToAddressL2'),
                _buildTableRow('BillToAddressL3', '$BillToAddressL3'),
                _buildTableRow('BillToState', '$BillToState'),
                _buildTableRow('BillToCountry', '$BillToCountry'),
                _buildTableRow('BillToCity', '$BillToCity'),
                _buildTableRow('BillToZipCode', '$BillToZipCode'),
                _buildTableRow('GSTNumber', '$GSTNumber'),
                _buildTableRow('GSTRegType', '$GSTRegType'),
                _buildTableRow('MSME', '$MSME'),
                _buildTableRow('EmailId', '$EmailId'),
                _buildTableRow('Telephone', '$Telephone'),
                _buildTableRow('MobilePhone', '$MobilePhone'),
                _buildTableRow('Website', '$Website'),
                _buildTableRow('Delivery Terms', '$DeliveryTerms'),
                _buildTableRow('Payment Terms', '$PaymentTerms'),
                _buildTableRow('Header Note', '$HeaderNote'),
                _buildTableRow('HSN Code', '$HSNCode'),
                _buildTableRow('PO Quantity', '$POQuantity'),
                _buildTableRow('Purchase UOM', '$PurchaseUOM'),
                _buildTableRow('Delivery Date', '$DeliveryDate'),
                _buildTableRow('Unit Price', '$UnitPrice'),
                _buildTableRow('Tax Code', '$TaxCode'),
                _buildTableRow('Tax Amount', '$TaxAmount'),
                _buildTableRow('Tax Percent', '$TaxPercent'),
                _buildTableRow('Line Total', '$LineTotal'),
                _buildTableRow('Final Amount', '$FinalAmount', isLastRow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String title, String value,
      {bool isFirstRow = false, bool isLastRow = false}) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            // borderRadius: BorderRadius.only(
            //   topLeft: isFirstRow ? Radius.circular(12) : Radius.zero,
            //   bottomLeft: isLastRow ? Radius.circular(12) : Radius.zero,
            // ),
            // border: Border.all(
            //   color: const Color.fromARGB(255, 124, 120, 120)!,
            //   width: 1.0,
            // ),
          ),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              title,
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
              textAlign: TextAlign.center,
              value,
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
