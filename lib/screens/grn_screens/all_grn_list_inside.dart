import 'package:erp_copy/controllers/grn_controllers/approve_reject/approve_grn_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/approve_reject/reject_grn_controllers.dart';
import 'package:erp_copy/controllers/grn_controllers/genrate_grn_pdf_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/get_grn_list_in_approval_controller.dart';
import 'package:erp_copy/model/grn_models/grn_list_in_approval_model.dart';
import 'package:erp_copy/widget/grn_cards/grn_list_in_approval_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GRNListInsideScreen extends StatefulWidget {
  const GRNListInsideScreen({
    super.key,
    required this.grnTxnID,
  });

  final int grnTxnID;

  @override
  State<GRNListInsideScreen> createState() => _GRNListInsideScreenState();
}

class _GRNListInsideScreenState extends State<GRNListInsideScreen> {
  TextEditingController searchController = TextEditingController();

  final GetGrnListInApprovalController grnliac =
      GetGrnListInApprovalController();

  final RejectGrnControllers rgc = Get.put(RejectGrnControllers());

  final ApproveGrnController agc = ApproveGrnController();

  List<GRNListInApprovalModel> itemList = [];
  List<GRNListInApprovalModel> filteredItemList = [];

  // Controllers for the TextFields
  TextEditingController totalAcceptedValueController = TextEditingController();
  TextEditingController totalAcceptedTaxAmountController =
      TextEditingController();
  TextEditingController finalAcceptedAmountController = TextEditingController();
  TextEditingController totalRejectedValueController = TextEditingController();
  TextEditingController totalRejectedTaxAmountController =
      TextEditingController();
  TextEditingController finalRejectedAmountController = TextEditingController();

  final GenrateGrnPdfController ggrnpdf = Get.put(GenrateGrnPdfController());

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterItems);
    _loadItemData();
  }

  void _loadItemData() async {
    var data = await grnliac.getGRNList(widget.grnTxnID);
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

  void _filterItems() {
    String query = searchController.text.toLowerCase();
    setState(() {
      // filteredItemList = itemList.where((item) {
      //   return item.grnTxnID!.().contains(query) ||
      //       item.itemName!.toLowerCase().contains(query) ||
      //       item.itemGroup!.toLowerCase().contains(query);
      // }).toList();
    });
  }

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
        title: const Text(
          'GRN list',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await ggrnpdf.generateGRNPdf(widget.grnTxnID);
              },
              child: const Text('generate')),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row to arrange the left and right side fields
            const SizedBox(height: 20),
            filteredItemList.isEmpty
                ? const Center(
                    child: Text('No items found'),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.90,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemList.length,
                      itemBuilder: (context, index) {
                        var item = filteredItemList[index];
                        return GestureDetector(
                          onTap: () {
                            // Get.to(WithoutBlockUnblockItemMasterDetailsScreen(
                            //   selectedItem: item,
                            // ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: GRNItemsInApprovalCard(
                              duration: 1,
                              poCode: item.poCode,
                              vendorName: item.vendorName,
                              vendorCode: item.vendorID.toString(),
                              venusId: item.itemID.toString(),
                              itemName: item.itemName,
                              itemGroup: item.itemGroup,
                              batchNo: item.batchNo,
                              serialNo: item.serialNo,
                              poQuantity: item.poQty.toString(),
                              poRate: item.poRate.toString(),
                              receivedQty: item.receivedQty.toString(),
                              acceptedQty: item.acceptedQty?.toString(),
                              rejectedQty: item.rejectedQty?.toString(),
                              receivedRate: item.receivedRate.toString(),
                              taxPercentages: item.taxPercent.toString(),
                              uom: item.purchaseUOM,
                              gateEntryNumber: item.gateEntryID.toString(),
                              poDate: item.poDate.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
