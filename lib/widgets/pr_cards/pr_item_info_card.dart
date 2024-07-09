import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class PRItemInfoCard extends StatelessWidget {
  const PRItemInfoCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.itemName,
    this.internalCode,
    this.reqQty,
    this.purchaseUOM,
    this.remarks,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final String? itemName;
  final String? internalCode;
  final String? reqQty;
  final String? purchaseUOM;
  final String? remarks;
  final dynamic duration;

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
          //  color: Color.fromARGB(243, 199, 80, 11),
          //color: Colors.red,
          child: AnimatedContainer(
            duration: Duration(milliseconds: duration),
            height: ht,
            width: wd,
            decoration: ColorCards.gradientDecoration,
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              // scrollDirection: Axis.horizontal,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 18),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              'ItemName     :    $itemName',
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
                              'PurchaseUOM   :  $purchaseUOM',
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
                              'InternalCode  :  $internalCode',
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
                              'ReqQty  :  $reqQty',
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
                              'Remarks  :  $remarks',
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
                    //////
                    const SizedBox(height: 6),
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
