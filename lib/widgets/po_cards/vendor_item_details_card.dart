import 'package:flutter/material.dart';

class VendorItemDetailsCard extends StatelessWidget {
  VendorItemDetailsCard({
    super.key,
    this.PODetailsID,
    this.POTransactionId,
    this.ItemID,
    this.SAP_ID,
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

  final String? PODetailsID;
  final String? POTransactionId;
  final String? ItemID;
  final String? SAP_ID;
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
    return Center(
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(200.0),
        border: TableBorder.all(
          color: Colors.green[300]!,
          width: 2.0,
          borderRadius: BorderRadius.circular(12),
        ),
        children: [
          _buildTableRow('PO Details ID', '$PODetailsID'),
          _buildTableRow('PO Transaction ID', '$POTransactionId'),
          _buildTableRow('Item ID', '$ItemID'),
          _buildTableRow('SAP ID', '$SAP_ID'),
          _buildTableRow('HSN Code', '$HSNCode'),
          _buildTableRow('PO Quantity', '$POQuantity'),
          _buildTableRow('Purchase UOM', '$PurchaseUOM'),
          _buildTableRow('Delivery Date', '$DeliveryDate'),
          _buildTableRow('Unit Price', '$UnitPrice'),
          _buildTableRow('Tax Code', '$TaxCode'),
          _buildTableRow('Tax Amount', '$TaxAmount'),
          _buildTableRow('Tax Percent', '$TaxPercent'),
          _buildTableRow('Line Total', '$LineTotal'),
          _buildTableRow('Final Amount', '$FinalAmount'),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(
              color: const Color.fromARGB(255, 124, 120, 120)!,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Text(
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
