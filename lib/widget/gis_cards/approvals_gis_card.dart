import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class GISApprovalCard extends StatelessWidget {
  const GISApprovalCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.gisNumber, // GIS Number
    this.txnDirection, // Txn Direction
    this.woTxnID, // WO TxnID
    this.txnDate, // Txn Date
    this.issueTo, // Issue To
    this.projectCode, // Project Code
    this.department, // Department
    this.userName, // User Name
    this.status, // Status
    this.type, // Type
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? gisNumber; // GIS Number
  final String? txnDirection; // Txn Direction
  final String? woTxnID; // WO TxnID
  final String? txnDate; // Txn Date
  final String? issueTo; // Issue To
  final String? projectCode; // Project Code
  final String? department; // Department
  final String? userName; // User Name
  final String? status; // Status
  final String? type; // Type

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
                  _buildRow('GIS Number', gisNumber),
                  _buildRow('Txn Direction', txnDirection),
                  _buildRow('WO TxnID', woTxnID),
                  _buildRow('Txn Date', txnDate),
                  _buildRow('Issue To', issueTo),
                  _buildRow('Project Code', projectCode),
                  _buildRow('Department', department),
                  _buildRow('User Name', userName),
                  _buildRow('Status', status),
                  _buildRow('Type', type),
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
