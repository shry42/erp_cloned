import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class GRNRejectedItemsCard extends StatelessWidget {
  const GRNRejectedItemsCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.grnTxnID,
    this.venusId,
    this.itemId,
    this.itemName,
    this.itemGroup,
    this.date,
    this.rejectedQty,
    this.amount,
    this.amountWithTax,
    this.currency,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? grnTxnID;
  final String? venusId;
  final String? itemId;
  final String? itemName;
  final String? itemGroup;
  final String? date;
  final String? rejectedQty;
  final String? amount;
  final String? amountWithTax;
  final String? currency;

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
                  _buildRow('GRN Txn ID', grnTxnID),
                  _buildRow('Venus Id', venusId),
                  _buildRow('Item Id', itemId),
                  _buildRow('Item Name', itemName),
                  _buildRow('Item Group', itemGroup),
                  _buildRow('Date', date),
                  _buildRow('Rejected Qty', rejectedQty),
                  _buildRow('Amount', amount),
                  _buildRow('Amount With Tax', amountWithTax),
                  _buildRow('Currency', currency),
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
