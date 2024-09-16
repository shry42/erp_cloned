import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class BlockItemListCard extends StatelessWidget {
  const BlockItemListCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.itemName,
    this.itemGroup,
    this.requestFor,
    this.reason,
    this.venusId,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final String? venusId;
  final dynamic duration;
  final String? itemName;
  final String? itemGroup;
  final String? requestFor;
  final String? reason;

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
                            'Venus Id   :   $venusId',
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
                            'itemn_Name :  $itemName',
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
                            'Item Group :  $itemGroup',
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
                            'Request for :  $requestFor',
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
                            'Reason :  $reason',
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
