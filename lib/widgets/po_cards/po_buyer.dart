import 'package:flutter/material.dart';

class PoBuyerCard extends StatelessWidget {
  const PoBuyerCard({
    super.key,
    this.Name,
    this.EmailId,
    this.Tel,
    this.Mob,
  });

  final String? Name;
  final String? EmailId;
  final String? Tel;
  final String? Mob;

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
                'BUYER DETAILS',
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
                    child: Text('Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Email ID',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Tel',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TableCell(
                    child: Text('Mob',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    child: Text('$Name', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$EmailId', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$Tel', textAlign: TextAlign.center),
                  ),
                  TableCell(
                    child: Text('$Mob', textAlign: TextAlign.center),
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
