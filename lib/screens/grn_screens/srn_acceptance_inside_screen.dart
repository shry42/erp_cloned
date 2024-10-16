import 'package:erp_copy/controllers/grn_controllers/get_srn_list_in_approval_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/get_srn_remarks_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/submit_grn/submit_grn_accepted_count.dart';
import 'package:erp_copy/controllers/grn_controllers/submit_grn/submit_srn_accepted_count.dart';
import 'package:erp_copy/controllers/vendor_master_controller/vendor_list_pdf_controller.dart';
import 'package:erp_copy/model/grn_models/srn_models/srn_acceptance_inside_items_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SRNItemsScreen extends StatefulWidget {
  const SRNItemsScreen({super.key, required this.GRNTxnID});

  final int GRNTxnID;

  @override
  State<SRNItemsScreen> createState() => _SRNItemsScreenState();
}

class _SRNItemsScreenState extends State<SRNItemsScreen> {
  final GetSrnListInApprovalController controller =
      Get.put(GetSrnListInApprovalController());

  final GetSrnRemarksController gsrc = Get.put(GetSrnRemarksController());

  final SubmitSrnAcceptedCountController sgrnac =
      Get.put(SubmitSrnAcceptedCountController());

  final GetVendorMasterPdfController gvpdfc =
      Get.put(GetVendorMasterPdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SRN Items'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await gvpdfc.getVednorMaster(widget.GRNTxnID, 'GRNTxnID');
              },
              child: const Text('view doc'))
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.srnList.isEmpty) {
          return const Center(child: Text('No SRN items found'));
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
                        DataColumn(label: Text('Service id')),
                        DataColumn(label: Text('Service name')),
                        DataColumn(label: Text('Service Group')),
                        DataColumn(label: Text('Batch No')),
                        DataColumn(label: Text('Serial No')),
                        DataColumn(label: Text('Received Qty')),
                        DataColumn(label: Text('Accepted Qty')),
                        DataColumn(label: Text('Remarks')),
                        DataColumn(label: Text('View Remark')),
                      ],
                      rows: controller.srnList.asMap().entries.map((entry) {
                        int index = entry.key;
                        SRNAcceptanceItemsInsideModel item = entry.value;

                        // Calculate rejected quantity dynamically
                        double rejectedQty =
                            (item.receivedQty ?? 0) - (item.acceptedQty ?? 0);

                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(item.serviceId.toString())),
                          DataCell(Text(item.serviceName ?? '')),
                          DataCell(Text(item.serviceGroup.toString())),
                          DataCell(Text(item.batchNo ?? '')),
                          DataCell(Text(item.serialNo ?? '')),
                          DataCell(Text(item.receivedQty.toString())),
                          DataCell(Text(item.acceptedQty?.toString() ?? '')),
                          DataCell(
                            TextFormField(
                              initialValue: item.remarks ?? '',
                              onChanged: (value) {
                                // item.remark = value; // Update remarks value
                              },
                            ),
                          ),
                          DataCell(ElevatedButton(
                            child: const Text('View'),
                            onPressed: () async {
                              // Implement view functionality
                              await gsrc.getGRNRemarks(
                                  widget.GRNTxnID, item.serviceId!.toInt());
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
                        controller.srnList.map((item) {
                      return {
                        "ServiceId": item.serviceId,
                        "acceptedQty": item.acceptedQty,
                        "remarks": item.remarks,
                        "BatchNo": item.batchNo,
                        "SerialNo": item.serialNo,
                      };
                    }).toList();

                    // Call the submitGRN method with GRNTxnID and the list of items
                    sgrnac.submitSRN(widget.GRNTxnID, grnData);

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
