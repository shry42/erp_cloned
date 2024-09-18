import 'package:erp_copy/controllers/grn_controllers/get_gate_entry_from_poid_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/get_po_items_controller.dart';
import 'package:erp_copy/controllers/grn_controllers/grn_basket/grn_basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemListDialog extends StatelessWidget {
  final GetPoItemsController controller = Get.find<GetPoItemsController>();
  final GRNBasketController grnBasketController =
      Get.put(GRNBasketController());
  final GetGateEntryFromPoidController _getEntryNo =
      Get.put(GetGateEntryFromPoidController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'PO Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('SR NO.')),
                        DataColumn(label: Text('Item Name')),
                        DataColumn(label: Text('Item Group')),
                        DataColumn(label: Text('HSN Code')),
                        DataColumn(label: Text('PO Qty')),
                        DataColumn(label: Text('Purchase UOM')),
                        DataColumn(label: Text('Delivery Date')),
                        DataColumn(label: Text('Unit Price')),
                        DataColumn(label: Text('Tax Code')),
                        DataColumn(label: Text('Tax Rate')),
                        DataColumn(label: Text('Line Total')),
                        DataColumn(label: Text('Tax Amount')),
                        DataColumn(label: Text('Final Amount')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: controller.poItems.map((item) {
                        return DataRow(cells: [
                          DataCell(Text((controller.poItems.indexOf(item) + 1)
                              .toString())),
                          DataCell(Text(item.itemName ?? 'N/A')),
                          DataCell(Text(item.itemGroup ?? 'N/A')),
                          DataCell(Text(item.hsnCode ?? 'N/A')),
                          DataCell(Text(item.poQty?.toString() ?? 'N/A')),
                          DataCell(Text(item.purchaseUOM ?? 'N/A')),
                          DataCell(Text(item.deliveryDate != null
                              ? item.deliveryDate!.toLocal().toString()
                              : 'N/A')),
                          DataCell(Text(item.unitPrice?.toString() ?? 'N/A')),
                          DataCell(Text(item.taxCode ?? 'N/A')),
                          DataCell(Text(item.taxPercent?.toString() ?? 'N/A')),
                          DataCell(Text(item.lineTotal?.toString() ?? 'N/A')),
                          DataCell(Text(item.taxAmt?.toString() ?? 'N/A')),
                          DataCell(Text(item.finalAmt?.toString() ?? 'N/A')),
                          DataCell(ElevatedButton(
                            onPressed: () {
                              grnBasketController.addPOItemToBasket(item);
                              _getEntryNo
                                  .getGateEntryFromPOID(item.poTxnID!.toInt());
                              Get.snackbar(
                                'Success',
                                '${item.itemName} added to GRN basket',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            style: ElevatedButton.styleFrom(),
                            child: const Text('Add'),
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              }
            }),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
