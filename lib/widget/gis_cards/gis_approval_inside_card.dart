import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class GISApprovalInsideCard extends StatelessWidget {
  const GISApprovalInsideCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.venusId, // Venus ID
    this.itemId, // Item ID
    this.internalCode, // Internal Code
    this.batchNo, // Batch No.
    this.serialNo, // Serial No.
    this.reqQuantity, // Required Quantity
    this.issuedQty, // Issued Quantity
    this.diffQty, // Difference Quantity
    this.balanceQty, // Balance Quantity
    this.availableQty, // Available Quantity
    this.purchaseUOM, // Purchase UOM
    this.remarks, // Remarks
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? venusId; // Venus ID
  final String? itemId; // Item ID
  final String? internalCode; // Internal Code
  final String? batchNo; // Batch No.
  final String? serialNo; // Serial No.
  final String? reqQuantity; // Required Quantity
  final String? issuedQty; // Issued Quantity
  final String? diffQty; // Difference Quantity
  final String? balanceQty; // Balance Quantity
  final String? availableQty; // Available Quantity
  final String? purchaseUOM; // Purchase UOM
  final String? remarks; // Remarks

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
                  _buildRow('Venus ID', venusId),
                  _buildRow('Item ID', itemId),
                  _buildRow('Internal Code', internalCode),
                  _buildRow('Batch No.', batchNo),
                  _buildRow('Serial No.', serialNo),
                  _buildRow('Required Quantity', reqQuantity),
                  _buildRow('Issued Quantity', issuedQty),
                  _buildRow('Difference Quantity', diffQty),
                  _buildRow('Balance Quantity', balanceQty),
                  _buildRow('Available Quantity', availableQty),
                  _buildRow('Purchase UOM', purchaseUOM),
                  _buildRow('Remarks', remarks),
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
