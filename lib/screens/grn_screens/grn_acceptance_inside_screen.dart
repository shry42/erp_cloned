import 'package:erp_copy/controllers/grn_controllers/get_grn_list_in_approval_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/get_grn_remarks_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/submit_grn_accepted_count.dart';
import 'package:erp_copy/model/grn_models/grn_list_in_acceptance_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GRNItemsScreen extends StatefulWidget {
  const GRNItemsScreen({super.key, required this.GRNTxnID});

  final int GRNTxnID;

  @override
  State<GRNItemsScreen> createState() => _GRNItemsScreenState();
}

class _GRNItemsScreenState extends State<GRNItemsScreen> {
  final GetGrnListInApprovalController controller = Get.find();

  final GetGrnRemarksController ggrc = Get.put(GetGrnRemarksController());

  final SubmitGrnAcceptedCountController sgrnac =
      Get.put(SubmitGrnAcceptedCountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRN Items'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.grnList.isEmpty) {
          return const Center(child: Text('No GRN items found'));
        } else {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('SR NO.')),
                        DataColumn(label: Text('PO TxnID')),
                        DataColumn(label: Text('Venus Id')),
                        DataColumn(label: Text('Item Id')),
                        DataColumn(label: Text('Item Name')),
                        DataColumn(label: Text('Item Group')),
                        DataColumn(label: Text('Batch No')),
                        DataColumn(label: Text('Serial No')),
                        DataColumn(label: Text('Received Qty')),
                        DataColumn(label: Text('Accepted Qty')),
                        DataColumn(label: Text('Rejected Qty')),
                        DataColumn(label: Text('Remarks')),
                        DataColumn(label: Text('View Remark')),
                      ],
                      rows: controller.grnAcceptanceList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        GRNListInAcceptanceModel item = entry.value;

                        // Calculate rejected quantity dynamically
                        double rejectedQty =
                            (item.receivedQty ?? 0) - (item.acceptedQty ?? 0);

                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(item.poTxnID.toString())),
                          DataCell(Text(item.sapID ?? '')),
                          DataCell(Text(item.itemID.toString())),
                          DataCell(Text(item.itemName ?? '')),
                          DataCell(Text(item.itemGroup ?? '')),
                          DataCell(Text(item.batchNo ?? '')),
                          DataCell(Text(item.serialNo ?? '')),
                          DataCell(Text(item.receivedQty.toString())),
                          DataCell(
                            TextFormField(
                              initialValue: item.acceptedQty?.toString() ?? '',
                              onChanged: (value) {
                                double acceptedValue =
                                    double.tryParse(value) ?? 0;
                                item.acceptedQty = acceptedValue;

                                // Calculate and update rejected quantity based on accepted quantity
                                item.rejectedQty =
                                    (item.receivedQty ?? 0) - acceptedValue;

                                // Refresh the UI to reflect the updated rejectedQty
                                controller.grnList.refresh();
                              },
                            ),
                          ),
                          DataCell(
                            Text(item.rejectedQty?.toString() ??
                                rejectedQty.toString()),
                          ),
                          DataCell(
                            TextFormField(
                              initialValue: item.remark ?? '',
                              onChanged: (value) {
                                item.remark = value; // Update remarks value
                              },
                            ),
                          ),
                          DataCell(ElevatedButton(
                            child: const Text('View'),
                            onPressed: () async {
                              // Implement view functionality
                              await ggrc.getGRNRemarks(
                                  widget.GRNTxnID, item.itemID!.toInt());
                            },
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    // Create a list of items to submit
                    List<Map<String, dynamic>> grnData =
                        controller.grnAcceptanceList.map((item) {
                      return {
                        "ItemID": item.itemID,
                        "acceptedQty": item.acceptedQty,
                        "rejectedQty": item.rejectedQty,
                        "remarks": item.remark,
                        "BatchNo": item.batchNo,
                        "SerialNo": item.serialNo,
                        "GRNDetailsID": item.grnDetailsID,
                      };
                    }).toList();

                    // Call the submitGRN method with GRNTxnID and the list of items
                    sgrnac.submitGRN(widget.GRNTxnID, grnData);

                    // Provide feedback to the user after submission
                    Get.snackbar(
                        'Submitting', 'Your GRN data is being submitted...');
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
