import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/approve_pr_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/department_list_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/pr_details_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/reject_pr_controller.dart';
import 'package:erp_copy/widgets/pr_cards/pr_item_info_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PrItemDetails extends StatefulWidget {
  final String PrTxnId;
  PrItemDetails({super.key, required this.PrTxnId});

  @override
  State<PrItemDetails> createState() => _PrItemDetailsState();
}

final PrDetailsController prdetailsItem = PrDetailsController();
final PrApproveResponse prapprovecont = PrApproveResponse();
final PrRejectResponse prRejectResponse = PrRejectResponse();
final DepartmentListController depListCont =
    Get.put(DepartmentListController());

double _height = 200;
double _width = 400;
dynamic _duration = 500;

class _PrItemDetailsState extends State<PrItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PR Items list'),
      ),
      body: FutureBuilder(
          future: prdetailsItem.getPrDetails(widget.PrTxnId),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/loaderr.gif',
                      height: 200,
                      width: 250,
                    ),
                    const Text('No records found')
                  ],
                )),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {},
                        child: PRItemInfoCard(
                          itemName: snapshot.data[index].itemName.toString(),
                          purchaseUOM: snapshot.data[index].purchaseUOM,
                          internalCode: snapshot.data[index].internalCode,
                          reqQty: snapshot.data[index].reqQty.toString(),
                          remarks: snapshot.data[index].remarks,
                          ht: _height,
                          wd: _width,
                          duration: _duration,
                        ),
                      ),
                    ),
                  ),

                  //Buttons /
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Shimmer(
                          duration: const Duration(seconds: 2),
                          // This is NOT the default value. Default value: Duration(seconds: 0)
                          interval: const Duration(seconds: 1),
                          // This is the default value
                          color: Colors.white,
                          // This is the default value
                          colorOpacity: 1,
                          // This is the default value
                          enabled: true,
                          // This is the default value
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            height: 40,
                            width: 118,
                            decoration: BoxDecoration(
                              // color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                await prapprovecont.prApprove(widget.PrTxnId);
                                if (AppController.message != null) {
                                  Get.defaultDialog(
                                    title: "Success!",
                                    middleText: "${AppController.message}",
                                    textConfirm: "OK",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () async {
                                      await depListCont.fetchDepList();
                                      // Get.offAll(
                                      //     const PrLogDetailsScreen()); // Close the dialog
                                    },
                                  );
                                  return;
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Approve',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Shimmer(
                          duration: const Duration(seconds: 2),
                          // This is NOT the default value. Default value: Duration(seconds: 0)
                          interval: const Duration(seconds: 1),
                          // This is the default value
                          color: Colors.white,
                          // This is the default value
                          colorOpacity: 1,
                          // This is the default value
                          enabled: true,
                          // This is the default value
                          direction: const ShimmerDirection.fromLTRB(),
                          child: Container(
                            height: 40,
                            width: 118,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                await prRejectResponse.prReject(widget.PrTxnId);
                                if (AppController.message != null) {
                                  Get.defaultDialog(
                                    title: "Success!",
                                    middleText: "${AppController.message}",
                                    textConfirm: "OK",
                                    confirmTextColor: Colors.white,
                                    onConfirm: () async {
                                      Get.back();
                                      // await depListCont.fetchDepList();
                                      // Get.offAll(
                                      //     const PrLogDetailsScreen()); // Close the dialog
                                    },
                                  );
                                  return;
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Reject',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }
          }),
    );
  }
}
