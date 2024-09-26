import 'package:erp_copy/controllers/gis_controllers/approve_gis_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/get_item_by_gis_controller.dart';
import 'package:erp_copy/controllers/gis_controllers/reject_gis_controller.dart';
import 'package:erp_copy/model/gis_model/get_item_by_gis_model.dart';
import 'package:erp_copy/widget/gis_cards/gis_approval_inside_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GISApprovalInsideScreen extends StatefulWidget {
  const GISApprovalInsideScreen({
    super.key,
    required this.GISTxnID,
  });
  final int GISTxnID;

  @override
  State<GISApprovalInsideScreen> createState() =>
      _GISApprovalInsideScreenState();
}

class _GISApprovalInsideScreenState extends State<GISApprovalInsideScreen> {
  TextEditingController searchController = TextEditingController();

  final GetItemByGisController gaglc = GetItemByGisController();

  final ApproveGisController agis = Get.put(ApproveGisController());

  final RejectGisController rgis = Get.put(RejectGisController());

  List<GetItemByGISModel> itemList = [];
  List<GetItemByGISModel> filteredItemList = [];

  @override
  void initState() {
    super.initState();
    // searchController.addListener(_filterItems);
    _loadItemData();
  }

  void _loadItemData() async {
    var data = await gaglc.getItemList(widget.GISTxnID);
    setState(() {
      if (data != null && data.isNotEmpty) {
        itemList = data;
        filteredItemList = data;
      } else {
        // Handle the case where no data is returned from API
        itemList = [];
        filteredItemList = [];
      }
    });
  }

  // void _filterItems() {
  //   String query =
  //       searchController.text.toLowerCase().trim(); // Trim whitespace
  //   setState(() {
  //     if (query.isEmpty) {
  //       // If the search query is empty, show all items
  //       filteredItemList = itemList;
  //     } else {
  //       filteredItemList = itemList.where((item) {
  //         return (item.grnTxID?.toString().toLowerCase().contains(query) ??
  //             false);
  //       }).toList();
  //     }
  //   });
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.sizeOf(context).height * 0.18;
    double _width = MediaQuery.sizeOf(context).width * 0.90;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 168, 71),
        automaticallyImplyLeading: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'GIS Details',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(width: 180),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: SizedBox(
                    height: 35,
                    width: 390,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        filled: true,
                        fillColor: const Color(0xfff1f1f1),
                        border: OutlineInputBorder(
                          gapPadding: 20,
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey)),
                        hintText: "Search by gis numbers",
                        hintStyle:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        suffixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            filteredItemList.isEmpty
                ? const Center(
                    child: Text('No items found'),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemList.length,
                      itemBuilder: (context, index) {
                        var item = filteredItemList[index];
                        return GestureDetector(
                          onTap: () {
                            // Get.to(GRNListInsideScreen(
                            //   grnTxnID: item.grnTxnID!.toInt(),
                            // ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: GISApprovalInsideCard(
                              duration: 1,

                              venusId: item.sapId, // Venus ID
                              itemId: item.itemId.toString(), // Item ID
                              internalCode: item.internalCode, // Internal Code
                              batchNo: item.batchNo, // Batch No
                              serialNo: item.serialNo, // Serial No.
                              reqQuantity:
                                  item.reqQty?.toString(), // Required Quantity
                              issuedQty:
                                  item.issuedQty?.toString(), // Issued Quantity
                              diffQty: item.diffQty
                                  ?.toString(), // Difference Quantity
                              balanceQty: item.balanceQty
                                  ?.toString(), // Balance Quantity
                              availableQty: item.unrestrictedStock
                                  ?.toString(), // Available Quantity
                              purchaseUOM: item.purchaseUom, // Purchase UOM
                              remarks: item.remarks, // Remarks
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Shimmer(
                    duration: const Duration(seconds: 2),
                    interval: const Duration(seconds: 1),
                    color: Colors.white,
                    colorOpacity: 1,
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    child: Container(
                      height: 50,
                      width: 118,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          await agis.approve(widget.GISTxnID);
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
                      height: 50,
                      width: 118,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          await rgis.reject(widget.GISTxnID);
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
          ],
        ),
      ),
    );
  }
}
