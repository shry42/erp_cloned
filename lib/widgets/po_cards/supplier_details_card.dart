import 'package:flutter/material.dart';

class POSupplierCard extends StatelessWidget {
  const POSupplierCard(
      {super.key,
      this.QuoteNo,
      this.Date,
      this.FinancialYear,
      this.POCName,
      this.EmailId,
      this.POCTel,
      this.POCMob});

  final String? QuoteNo;
  final String? Date;
  final String? FinancialYear;

  final String? POCName;
  final String? EmailId;
  final String? POCTel;
  final String? POCMob;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.grey.shade800,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'SUPPLIER DETAILS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                children: [
                  TableCell(
                    child: Text('Quote No',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Date',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Financial Year',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text('$QuoteNo', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$Date', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$FinancialYear', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.grey.shade800,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'SUPPLIER CONTACT DETAILS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                children: [
                  TableCell(
                    child: Text('POC Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Email ID',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('POC Tel',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('POC Mob',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text('$POCName', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$EmailId', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$POCTel', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$POCMob', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
