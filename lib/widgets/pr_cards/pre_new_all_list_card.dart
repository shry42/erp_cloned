import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class PRListsNewCard extends StatelessWidget {
  const PRListsNewCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.prTxnID, // PR Txn ID
    this.txnDate, // Txn Date
    this.requestDate, // Request Date
    this.projectCode, // Project Code
    this.department, // Department
    this.approvalStatus, // Approval Status
    this.approvedAt, // Approved At
    this.prStatus, // PR Status
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? prTxnID; // PR Txn ID
  final String? txnDate; // Txn Date
  final String? requestDate; // Request Date
  final String? projectCode; // Project Code
  final String? department; // Department
  final String? approvalStatus; // Approval Status
  final String? approvedAt; // Approved At
  final String? prStatus; // PR Status

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
                  _buildRow('PR Txn ID', prTxnID),
                  _buildRow('Txn Date', txnDate),
                  _buildRow('Request Date', requestDate),
                  _buildRow('Project Code', projectCode),
                  _buildRow('Department', department),
                  _buildRow('Approval Status', approvalStatus),
                  _buildRow('Approved At', approvedAt),
                  _buildRow('PR Status', prStatus),
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
      padding: const EdgeInsets.only(top: 8, left: 18),
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
