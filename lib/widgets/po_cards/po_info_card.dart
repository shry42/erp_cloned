import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class POInfoCard extends StatelessWidget {
  const POInfoCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.POTxnID,
    this.POCode,
    this.PODate,
    this.poStatus,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? POTxnID;
  final String? POCode;
  final String? PODate;
  final String? poStatus;

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
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 18),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'POTxnID   :   $POTxnID',
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
                          'POCode :  $POCode',
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
                          'PODate :  $PODate',
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
                          'POStatus :  $poStatus',
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
              ]),
              //
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
