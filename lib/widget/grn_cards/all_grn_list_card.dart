import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class AllGRNListCard extends StatelessWidget {
  const AllGRNListCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.grnNumber, // GRN Number
    this.invoiceNo, // Invoice No.
    this.invoiceDate, // Invoice Date
    this.challanNo, // Challan No.
    this.grnDate, // GRN Date
    this.createdBy, // Created By
    this.vendorName, // Vendor Name
    this.status, // Status
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? grnNumber; // GRN Number
  final String? invoiceNo; // Invoice No.
  final String? invoiceDate; // Invoice Date
  final String? challanNo; // Challan No.
  final String? grnDate; // GRN Date
  final String? createdBy; // Created By
  final String? vendorName; // Vendor Name
  final String? status; // Status

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          elevation: 8,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: duration),
            height: ht,
            width: wd,
            decoration: ColorCards.gradientDecoration,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildRow('GRN Number', grnNumber),
                  _buildRow('Invoice No.', invoiceNo),
                  _buildRow('Invoice Date', invoiceDate),
                  _buildRow('Challan No.', challanNo),
                  _buildRow('GRN Date', grnDate),
                  _buildRow('Created By', createdBy),
                  _buildRow('Vendor Name', vendorName),
                  _buildRow('Status', status),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Padding _buildRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, left: 18),
      child: Row(
        children: [
          Flexible(
            child: Text(
              '$label :  $value',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
