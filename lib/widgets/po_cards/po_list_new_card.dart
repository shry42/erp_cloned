import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class POListsNewCard extends StatelessWidget {
  const POListsNewCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.srNo, // SR NO.
    this.poTxnID, // PO TxnID
    this.prTxnID, // PR TxnID
    this.poCode, // PO Code
    this.poDate, // PO Date
    this.department, // Department
    this.status, // Status
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? srNo; // SR NO.
  final String? poTxnID; // PO TxnID
  final String? prTxnID; // PR TxnID
  final String? poCode; // PO Code
  final String? poDate; // PO Date
  final String? department; // Department
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
                  _buildRow('SR NO.', srNo),
                  _buildRow('PO TxnID', poTxnID),
                  _buildRow('PR TxnID', prTxnID),
                  _buildRow('PO Code', poCode),
                  _buildRow('PO Date', poDate),
                  _buildRow('Department', department),
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
      padding: const EdgeInsets.only(top: 8, left: 18, bottom: 6),
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
