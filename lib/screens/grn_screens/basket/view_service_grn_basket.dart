import 'dart:io';
import 'package:erp_copy/controllers/grn_controllers/get_gate_entry_from_poid_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/grn_basket/service_grn_basket_controller.dart';
import 'package:erp_copy/model/grn_models/grn_basket_item_model.dart';
import 'package:erp_copy/model/grn_models/service_grn_basket_item_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewServiceGRNBasketScreen extends StatefulWidget {
  const ViewServiceGRNBasketScreen({
    super.key,
    this.remark,
    this.invoiceNumber,
    this.grnNumber,
    this.grnDate,
    this.invoiceDate,
    this.challanNumber,
    required this.files,
  });

  final String? invoiceNumber;
  final String? invoiceDate;
  final String? grnNumber;
  final String? grnDate;
  final String? challanNumber;
  final String? remark;
  final List<PlatformFile> files;

  @override
  State<ViewServiceGRNBasketScreen> createState() =>
      _ViewServiceGRNBasketScreenState();
}

class _ViewServiceGRNBasketScreenState
    extends State<ViewServiceGRNBasketScreen> {
  final ServiceGRNBasketController serviceGrnBasketController =
      Get.put(ServiceGRNBasketController());
  final GetGateEntryFromPoidController _getEntryNo =
      Get.put(GetGateEntryFromPoidController());

  // Map to store selected Gate Entry ID for each row
  final Map<int, int?> selectedGateEntryIdMap = {};

  @override
  void initState() {
    super.initState();
    // Assuming a PO TxnID is available, replace 263 with the actual ID
    _getEntryNo.getGateEntryFromPOID(263); // Fetch gate entry numbers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Service GRN Basket Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 16.0,
                    columns: const [
                      DataColumn(label: Text('SR NO.')),
                      DataColumn(label: Text('PO TxnID')),
                      DataColumn(label: Text('Service ID')),
                      DataColumn(label: Text('Service Name')),

                      DataColumn(label: Text('Service Group')),
                      DataColumn(label: Text('Batch No.')),
                      DataColumn(label: Text('Serial No')),
                      DataColumn(label: Text('PO Quantity')),
                      DataColumn(label: Text('Unit Price')),
                      DataColumn(label: Text('Received Quantity')),
                      DataColumn(label: Text('Received Rate')),
                      DataColumn(
                          label: Text('Gate Entry ID')), // This will be updated
                      DataColumn(label: Text('Purchase UOM')),
                      DataColumn(label: Text('Total Received Quantity')),
                      DataColumn(label: Text('Remaining Quantity')),
                      DataColumn(label: Text('Accepted Quantity')),
                    ],
                    rows: serviceGrnBasketController.serviceBasketItems
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      ServiceGRNBasketItem item = entry.value;

                      // Ensure that each row has its selectedGateEntryIdMap entry
                      if (!selectedGateEntryIdMap.containsKey(index)) {
                        selectedGateEntryIdMap[index] =
                            int.tryParse(item.gateEntryId ?? '');
                      }

                      return DataRow(cells: [
                        DataCell(Text((index + 1).toString() ?? 'N/A')),
                        DataCell(Text(item.poTxnId ?? 'N/A')),
                        DataCell(Text(item.serviceId ?? 'N/A')),
                        DataCell(Text(item.serviceName ?? 'N/A')),

                        DataCell(Text(item.serviceGroup ?? 'N/A')),
                        DataCell(TextFormField(
                          initialValue: item.batchNumber,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                          ),
                          onChanged: (value) {
                            serviceGrnBasketController.updateBatchNumber(
                                index, value);
                          },
                        )),
                        DataCell(TextFormField(
                          initialValue: item.serialNumber,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                          ),
                          onChanged: (value) {
                            serviceGrnBasketController.updateSerialNumber(
                                index, value);
                          },
                        )),
                        DataCell(Text(item.poQuantity?.toString() ?? 'N/A')),
                        DataCell(Text(item.unitPrice?.toString() ?? 'N/A')),

                        // Received Quantity
                        DataCell(TextFormField(
                          initialValue: item.receivedQuantity?.toString(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                          ),
                          onChanged: (value) {
                            serviceGrnBasketController.updateReceivedQuantity(
                                index, value);
                          },
                        )),

                        // Received Rate
                        DataCell(TextFormField(
                          initialValue: item.receivedRate?.toString(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                          ),
                          onChanged: (value) {
                            serviceGrnBasketController.updateReceivedRate(
                                index, value);
                          },
                        )),

                        // Gate Entry ID dropdown
                        DataCell(
                          Obx(() {
                            var gateEntryNos = _getEntryNo.gateEntryNos;

                            // If the data is still loading, show a loading spinner
                            if (_getEntryNo.isLoading.isTrue) {
                              return CircularProgressIndicator();
                            }

                            // Ensure that the dropdown items list is not empty
                            if (gateEntryNos.isEmpty) {
                              return const Text("No Gate Entries Available");
                            }

                            return DropdownButton<int>(
                              value: selectedGateEntryIdMap[
                                  index], // Use the map to get the value
                              hint: const Text('Select Gate Entry'),
                              isExpanded: true,
                              items: gateEntryNos.map((entry) {
                                return DropdownMenuItem<int>(
                                  value: entry.gateEntryID,
                                  child: Text(entry.gateEntryID.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                // Update the selected value in the map
                                setState(() {
                                  selectedGateEntryIdMap[index] = newValue;
                                  serviceGrnBasketController.updateGateEntryId(
                                      index, newValue.toString());
                                });
                              },
                            );
                          }),
                        ),

                        DataCell(Text(item.purchaseUOM ?? 'N/A')),
                        DataCell(Text(item.totalReceivedQuantity ?? 'N/A')),
                        DataCell(Text(item.remainingQuantity ?? 'N/A')),

                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              serviceGrnBasketController
                                  .removeItemFromBasket(index);
                            },
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement submit functionality
                    serviceGrnBasketController.submitServiceGRNBasket(
                      grnDate: widget.grnDate,
                      grnNumber: widget.grnNumber,
                      invoiceDate: widget.invoiceDate,
                      invoiceNumber: widget.invoiceNumber,
                      challanNumber: widget.challanNumber,
                      remark: widget.remark,
                      files: widget.files,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement reset functionality
                    serviceGrnBasketController.resetBasket();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
