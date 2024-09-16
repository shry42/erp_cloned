import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PRItemInfoCard extends StatelessWidget {
  const PRItemInfoCard({
    super.key,
    this.ht,
    this.wd,
    this.duration,
    this.color,
    this.itemName,
    this.purchaseUOM,
    this.internalCode,
    this.reqQty,
    this.remarks,
    this.poStatus,
  });

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? itemName;
  final String? purchaseUOM;
  final String? internalCode;
  final String? reqQty;
  final String? remarks;
  final String? poStatus;
  final Color? color;

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  String truncateText(String text, double maxWidth, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    if (textPainter.didExceedMaxLines) {
      final int endIndex =
          textPainter.getPositionForOffset(Offset(maxWidth, 0)).offset;
      return truncateWithEllipsis(endIndex, text);
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.kameron(
      textStyle: const TextStyle(
        fontSize: 11,
        color: Color.fromARGB(255, 55, 141, 49),
      ),
    );

    return Column(
      children: [
        Stack(
          children: [
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
                            child: Tooltip(
                              message: itemName,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 80),
                                child: Text(
                                  truncateText(itemName ?? '', 80, textStyle),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Tooltip(
                              message: purchaseUOM,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 80),
                                child: Text(
                                  truncateText(
                                      purchaseUOM ?? '', 80, textStyle),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Tooltip(
                              message: internalCode,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 80),
                                child: Text(
                                  truncateText(
                                      internalCode ?? '', 80, textStyle),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45, right: 20),
                            child: Tooltip(
                              message: reqQty,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 80),
                                child: Text(
                                  truncateText(reqQty ?? '', 80, textStyle),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Tooltip(
                              message: remarks,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 80),
                                child: Text(
                                  truncateText(remarks ?? '', 80, textStyle),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      child: Text('Item Name',
                          style: GoogleFonts.kameron(
                              textStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text('Purchase UOM',
                          style: GoogleFonts.kameron(
                              textStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text('Internal Code',
                          style: GoogleFonts.kameron(
                              textStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text('Required Qty',
                          style: GoogleFonts.kameron(
                              textStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Text('Remarks',
                          style: GoogleFonts.kameron(
                              textStyle: const TextStyle(
                                  fontSize: 11, color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
