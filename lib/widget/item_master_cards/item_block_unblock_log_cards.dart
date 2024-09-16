import 'package:erp_copy/utils/color_for_Cards.dart';
import 'package:flutter/material.dart';

class ItemBlockUnblockLogCard extends StatelessWidget {
  const ItemBlockUnblockLogCard({
    Key? key,
    this.ht,
    this.wd,
    this.duration,
    this.venusid,
    this.itemName,
    this.itemGroup,
    this.itemId,
    this.status,
    this.blockUnblockAt,
    this.superAdminstatus,
    this.remark,
  }) : super(key: key);

  final double? ht;
  final double? wd;
  final dynamic duration;
  final String? itemId;
  final String? venusid;
  final String? itemName;
  final String? itemGroup;
  final String? status;
  final String? blockUnblockAt;
  final String? superAdminstatus;
  final String? remark;

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
                            'Item Id   :   $itemId',
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
                            'Venus Id :  $venusid',
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
                            'Item Name :  $itemName',
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
                            'Status :  $status',
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
                            'blockUnblock At :  $blockUnblockAt',
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
                            'Superadmin status :  $superAdminstatus',
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
                            'Remark :  $remark',
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
