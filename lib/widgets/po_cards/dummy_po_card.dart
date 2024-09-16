import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class POLogCards extends StatelessWidget {
  const POLogCards(
      {super.key,
      this.ht,
      this.wd,
      this.duration,
      this.POTxnID,
      this.POCode,
      this.PODate,
      this.poStatus,
      this.color});

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? POTxnID;
  final String? POCode;
  final String? PODate;
  final String? poStatus;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
            height: 80,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  width: 1, color: const Color.fromARGB(255, 60, 59, 59)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text('$POTxnID',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 65),
                          child: Text('$POCode',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Text('$PODate',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            '$poStatus',
                            style: GoogleFonts.kameron(
                              textStyle: TextStyle(
                                fontSize: 11,
                                // color: Color.fromARGB(255, 55, 141, 49),
                                color: color ?? Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            height: 40,
            width: 400,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color.fromARGB(243, 84, 86, 80),
                  // Color.fromARGB(243, 77, 234, 88),
                  Color.fromARGB(255, 181, 188, 180),
                ],
              ),
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 39, 37, 37),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('PO TxnID',
                        style: GoogleFonts.kameron(
                            textStyle: const TextStyle(
                                fontSize: 11, color: Colors.white))),
                  ),
                  Text('PO Code',
                      style: GoogleFonts.kameron(
                          textStyle: const TextStyle(
                              fontSize: 11, color: Colors.white))),
                  Text('PO Date',
                      style: GoogleFonts.kameron(
                          textStyle: const TextStyle(
                              fontSize: 11, color: Colors.white))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('PO Status',
                        style: GoogleFonts.kameron(
                            textStyle: const TextStyle(
                                fontSize: 11, color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ]),
        const SizedBox(height: 15),
      ],
    );
  }
}
