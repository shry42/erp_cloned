import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class GRNAcceptanceCard extends StatelessWidget {
  const GRNAcceptanceCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.grnNumber,
    this.submittedOn,
    this.createdBy,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? grnNumber; // Changed parameter name
  final String? submittedOn; // Changed parameter name
  final String? createdBy; // Changed parameter name

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
                  _buildRow('Submitted On', submittedOn),
                  _buildRow('Created By', createdBy),
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
