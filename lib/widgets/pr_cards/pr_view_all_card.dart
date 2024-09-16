import 'dart:ui';
import 'package:erp_copy/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PRViewAllCards extends StatelessWidget {
  const PRViewAllCards(
      {super.key,
      this.ht,
      this.wd,
      this.duration,
      this.color,
      this.PRTxnID,
      this.PRTxnDate,
      this.ReqDate,
      this.ProjectCode,
      this.PRStatus,
      this.poStatus});

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? PRTxnID;
  final String? PRTxnDate;
  final String? ReqDate;
  final String? ProjectCode;
  final String? PRStatus;

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
                          padding: const EdgeInsets.only(left: 15),
                          child: Text('$PRTxnID',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text('$PRTxnDate',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text('$ReqDate',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45, right: 20),
                          child: Text('$ProjectCode',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text('$PRStatus',
                              style: GoogleFonts.kameron(
                                  textStyle: const TextStyle(
                                      fontSize: 11,
                                      color:
                                          Color.fromARGB(255, 55, 141, 49)))),
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
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('PRTxnID',
                        style: GoogleFonts.kameron(
                            textStyle: const TextStyle(
                                fontSize: 11, color: Colors.white))),
                  ),
                  Text('PRTxnDate',
                      style: GoogleFonts.kameron(
                          textStyle: const TextStyle(
                              fontSize: 11, color: Colors.white))),
                  Text('ReqDate',
                      style: GoogleFonts.kameron(
                          textStyle: const TextStyle(
                              fontSize: 11, color: Colors.white))),
                  Text('ProjectCode',
                      style: GoogleFonts.kameron(
                          textStyle: const TextStyle(
                              fontSize: 11, color: Colors.white))),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('PRStatus',
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
