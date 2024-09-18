import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class GateEntryCard extends StatelessWidget {
  const GateEntryCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.gateEntryID,
    this.challanNo,
    this.challanDate,
    this.poCode,
    this.itemCount,
    this.receivedDate,
    this.receivedByUser,
    this.authorizerUserName,
    this.grnDone,
    this.remarks,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final int? gateEntryID;
  final String? challanNo;
  final DateTime? challanDate;
  final String? poCode;
  final String? itemCount;
  final DateTime? receivedDate;
  final String? receivedByUser;
  final String? authorizerUserName;
  final bool? grnDone;
  final String? remarks;

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
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'GateEntryID: $gateEntryID',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Challan No: $challanNo',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Challan Date: ${challanDate?.toLocal().toString()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'PO Code: $poCode',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Item Count: $itemCount',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Received Date: ${receivedDate?.toLocal().toString()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Received By: $receivedByUser',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Authorized By: $authorizerUserName',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'GRN Done: ${grnDone == true ? "Yes" : "No"}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 18),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Remarks: $remarks',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
}
