import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class GRNItemsInApprovalCard extends StatelessWidget {
  const GRNItemsInApprovalCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.poCode,
    this.vendorName,
    this.vendorCode,
    this.venusId,
    this.itemName,
    this.itemGroup,
    this.batchNo,
    this.serialNo,
    this.poQuantity,
    this.poRate,
    this.receivedQty,
    this.acceptedQty,
    this.rejectedQty,
    this.receivedRate,
    this.taxPercentages,
    this.uom,
    this.gateEntryNumber,
    this.poDate,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? poCode;
  final String? vendorName;
  final String? vendorCode;
  final String? venusId;
  final String? itemName;
  final String? itemGroup;
  final String? batchNo;
  final String? serialNo;
  final String? poQuantity;
  final String? poRate;
  final String? receivedQty;
  final String? acceptedQty;
  final String? rejectedQty;
  final String? receivedRate;
  final String? taxPercentages;
  final String? uom;
  final String? gateEntryNumber;
  final String? poDate;

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
                  _buildRow('PO Code', poCode),
                  _buildRow('Vendor Name', vendorName),
                  _buildRow('Vendor Code', vendorCode),
                  _buildRow('Venus Id', venusId),
                  _buildRow('Item Name', itemName),
                  _buildRow('Item Group', itemGroup),
                  _buildRow('Batch No', batchNo),
                  _buildRow('Serial No', serialNo),
                  _buildRow('PO Quantity', poQuantity),
                  _buildRow('PO Rate', poRate),
                  _buildRow('Received Qty', receivedQty),
                  _buildRow('Accepted Qty', acceptedQty),
                  _buildRow('Rejected Qty', rejectedQty),
                  _buildRow('Received Rate', receivedRate),
                  _buildRow('Tax Percentages', taxPercentages),
                  _buildRow('UOM', uom),
                  _buildRow('Gate Entry Number', gateEntryNumber),
                  _buildRow('PO Date', poDate),
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
