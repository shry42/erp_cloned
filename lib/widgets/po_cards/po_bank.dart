import 'package:flutter/material.dart';

class PoBankCard extends StatelessWidget {
  const PoBankCard({
    super.key,
    this.Street,
    this.City,
    this.State,
    this.Branch,
    this.ZipCode,
    this.AccountNo,
    this.Name,
    this.IFSCCode,
  });

  final String? Street;
  final String? City;
  final String? State;
  final String? Branch;
  final String? ZipCode;

  final String? AccountNo;
  final String? Name;
  final String? IFSCCode;

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
                'BANK DETAILS',
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
                    child: Text('Street',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('City',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('State',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Branch',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('ZipCode',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text('$Street', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$City', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$State', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$Branch', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$ZipCode', textAlign: TextAlign.center),
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
                'ACCOUNT DETAILS',
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
                    child: Text('Account No',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('IFSC Code',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text('$AccountNo', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$Name', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$IFSCCode', textAlign: TextAlign.center),
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
