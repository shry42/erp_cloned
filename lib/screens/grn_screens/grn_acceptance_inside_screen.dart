import 'package:erp_copy/controllers/grn_controllers/get_grn_list_in_approval_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:erp_copy/model/grn_models/grn_list_in_approval_model.dart';

class GRNItemsScreen extends StatelessWidget {
  final GetGrnListInApprovalController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GRN Items'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.grnList.isEmpty) {
          return Center(child: Text('No GRN items found'));
        } else {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
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
                      rows: controller.grnList.asMap().entries.map((entry) {
                        int index = entry.key;
                        GRNListInApprovalModel item = entry.value;

                        List<DataCell> cells = [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(item.poTxnID.toString())),
                          DataCell(Text(item.sapID ?? '')),
                          DataCell(Text(item.itemID.toString() ?? '')),
                          DataCell(Text(item.itemName ?? '')),
                          DataCell(Text(item.itemGroup ?? '')),
                          DataCell(Text(item.batchNo ?? '')),
                          DataCell(Text(item.serialNo ?? '')),
                          DataCell(Text(item.receivedQty.toString())),
                          DataCell(TextFormField(
                            initialValue: item.acceptedQty?.toString() ?? '',
                            onChanged: (value) {
                              item.acceptedQty =
                                  value as double; // Update value
                            },
                          )),
                          DataCell(TextFormField(
                            initialValue: item.rejectedQty?.toString() ?? '',
                            onChanged: (value) {
                              item.rejectedQty =
                                  value as double; // Update value
                            },
                          )),
                          DataCell(Text(item.gateEntryID.toString() ?? '')),
                          DataCell(ElevatedButton(
                            child: Text('View'),
                            onPressed: () {
                              // Implement view functionality
                            },
                          )),
                        ];

                        // Debugging output
                        print('Row $index has ${cells.length} cells: $cells');

                        // Check if cells count matches
                        if (cells.length != 13) {
                          print(
                              'Error: Row $index has ${cells.length} cells, expected 13');
                        }

                        return DataRow(cells: cells);
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    // Implement submit functionality
                    print('Submitting updated GRN items');
                    // You might want to call a method on your controller here
                    // to handle the submission of updated data
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
