import 'package:erp_copy/controllers/grn_controllers/approve_reject/approve_grn_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/approve_reject/reject_grn_controllers.dart';
import 'package:erp_copy/controllers/grn_controllers/get_grn_list_in_approval_controller.dart';
import 'package:erp_copy/model/grn_models/grn_list_in_approval_model.dart';
import 'package:erp_copy/widget/grn_cards/grn_list_in_approval_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class GRNListInApprovalScreen extends StatefulWidget {
  const GRNListInApprovalScreen({
    super.key,
    required this.grnTxnID,
  });

  final int grnTxnID;

  @override
  State<GRNListInApprovalScreen> createState() =>
      _GRNListInApprovalScreenState();
}

class _GRNListInApprovalScreenState extends State<GRNListInApprovalScreen> {
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

        // For total accepted values
        totalAcceptedValueController.text =
            filteredItemList.first.acceptedQtyValue?.toString() ?? '0';

        totalAcceptedTaxAmountController.text =
            filteredItemList.first.acceptedValueTaxAmount?.toString() ?? '0';

        final acceptedQtyValue = filteredItemList.first.acceptedQtyValue ?? 0;
        final acceptedValueTaxAmount =
            filteredItemList.first.acceptedValueTaxAmount ?? 0;
        final totalAccepted = acceptedQtyValue + acceptedValueTaxAmount;

        finalAcceptedAmountController.text = '$totalAccepted (In INR)';

// For total rejected values
        totalRejectedValueController.text =
            filteredItemList.first.rejectedQtyValue?.toString() ?? '0';

        totalRejectedTaxAmountController.text =
            filteredItemList.first.rejectedValueTaxAmount?.toString() ?? '0';

        final rejectedQtyValue = filteredItemList.first.rejectedQtyValue ?? 0;
        final rejectedValueTaxAmount =
            filteredItemList.first.rejectedValueTaxAmount ?? 0;
        final totalRejected = rejectedQtyValue + rejectedValueTaxAmount;

        finalRejectedAmountController.text = '$totalRejected (In INR)';
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
          'GRN list Approval',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row to arrange the left and right side fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side fields
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: totalAcceptedValueController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Total Accepted value',

                            filled: true,
                            fillColor:
                                Colors.grey[200], // Light grey background
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: totalAcceptedTaxAmountController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Total Accepted Tax Amount',
                            // suffixText: '0 (In INR)',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: finalAcceptedAmountController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Final Accepted Amount',
                            // suffixText: '0 (In INR)',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20), // Add space between columns

                  // Right side fields
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: totalRejectedValueController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Total Rejected value',
                            // suffixText: '0 (In INR)',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: totalRejectedTaxAmountController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Total Rejected Tax Amount',
                            // suffixText: '0 (In INR)',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: finalRejectedAmountController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Final Rejected Amount',
                            // suffixText: '0 (In INR)',
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            filteredItemList.isEmpty
                ? const Center(
                    child: Text('No items found'),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.52,
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
            const SizedBox(height: 20),
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
                      height: 40,
                      width: 118,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          // Parse the final rejected amount from the controller
                          double finalRejectedAmount = double.tryParse(
                                  finalRejectedAmountController.text
                                      .replaceAll(RegExp(r'[^\d.]'), '')) ??
                              0.0;

                          if (finalRejectedAmount > 0) {
                            // Show the dialog if there's a rejected amount
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Would you like to scrap OR add credit note these items ?'),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete),
                                            Text('Scrap'),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          agc.getApprovedGRN(
                                            grnTxnID: widget.grnTxnID,
                                            grnRejectType: 'scrap',
                                            creditNoteNumber: '',
                                            filePath: '',
                                          );
                                        },
                                      ),
                                      ElevatedButton(
                                        child: Row(
                                          children: [
                                            Icon(Icons.note_add),
                                            Text('Credit Note'),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return GrnApprovalDialog(
                                                grnTxnID: widget.grnTxnID,
                                                onApprove: (grnRejectType,
                                                    creditNoteNumber,
                                                    filePath) {
                                                  agc.getApprovedGRN(
                                                    grnTxnID: widget.grnTxnID,
                                                    grnRejectType:
                                                        grnRejectType,
                                                    creditNoteNumber:
                                                        creditNoteNumber,
                                                    filePath: filePath,
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            await agc.getApprovedGRN(
                              grnTxnID: widget.grnTxnID,
                              grnRejectType: '',
                              creditNoteNumber: '',
                              filePath: '',
                            );
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
                          await rgc.rejectGRN(widget.grnTxnID);
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
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class GrnApprovalDialog extends StatefulWidget {
  final int grnTxnID;
  final Function(String, String, String) onApprove;

  GrnApprovalDialog({required this.grnTxnID, required this.onApprove});

  @override
  _GrnApprovalDialogState createState() => _GrnApprovalDialogState();
}

class _GrnApprovalDialogState extends State<GrnApprovalDialog> {
  TextEditingController _creditNoteController = TextEditingController();
  String _fileName = 'No file chosen';
  PlatformFile? _file;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _fileName = result.files.single.name;
        _file = result.files.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('GRN Approval'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _creditNoteController,
            decoration: InputDecoration(
              labelText: 'Credit note number',
              hintText: 'Please enter credit note number',
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Upload files'),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Choose files'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    _fileName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onApprove(
                'credit', _creditNoteController.text, _file?.path ?? '');
            Navigator.of(context).pop();
          },
          child: Text('Approve'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back, size: 16),
              SizedBox(width: 5),
              Text('Go back'),
            ],
          ),
        ),
      ],
    );
  }
}
