import 'package:erp_copy/controllers/grn_controllers/grn_rejected_list_inside_controller.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrnRejectedItemsScreen extends StatelessWidget {
  final int grnTxnId; // Accepting the GRNTxnID
  GrnRejectedItemsScreen({required this.grnTxnId});

  final GrnRejectedListInsideController controller =
      Get.put(GrnRejectedListInsideController()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    // Fetch the data
    controller.getRejectedList(grnTxnId);

    return Scaffold(
      appBar: AppBar(
        title: Text("GRN Rejected Items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.grnRejectedList.isEmpty) {
            return Center(child: Text("No rejected items found"));
          }

          // Build the DataTable using the fetched data
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // First Data Table (GRN Rejected Items)
                DataTable(
                  columns: const [
                    DataColumn(label: Text('SR NO.')),
                    DataColumn(label: Text('Item ID')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Credit Note Number')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Amount With Tax')),
                  ],
                  rows: controller.grnRejectedList.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(
                          '${controller.grnRejectedList.indexOf(item) + 1}')),
                      DataCell(Text('${item.itemID}')),
                      DataCell(Text('${item.qty}')),
                      DataCell(Text('${item.creditNoteDetails}')),
                      DataCell(Text('${item.amount}')),
                      DataCell(Text('${item.amountWithTax}')),
                    ]);
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Display file table only once for all files, not for each rejected item
                _buildFileTable(
                    controller.grnRejectedList.first.files.toString()),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Method to build the file table for each item
  Widget _buildFileTable(String filePaths) {
    List<String> files = filePaths.split(',');

    return DataTable(
      columns: const [
        DataColumn(label: Text('SR NO.')),
        DataColumn(label: Text('File Name')),
        DataColumn(label: Text('Action')),
      ],
      rows: List<DataRow>.generate(files.length, (index) {
        String filePath = files[index]; // Get the full file path
        String fileName =
            files[index].split('/').last; // Extract file name from path
        return DataRow(cells: [
          DataCell(Text('${index + 1}')), // SR No.
          DataCell(Text(fileName)), // File name
          DataCell(
            ElevatedButton(
              onPressed: () {
                // Handle file view action here
                print('View File: $fileName');
                Get.to(PdfViewerScreen(filePath: filePath));
              },
              child: const Text('View'),
            ),
          ),
        ]);
      }),
    );
  }
}
