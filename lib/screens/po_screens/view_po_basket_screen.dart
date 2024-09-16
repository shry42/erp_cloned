import 'package:erp_copy/controllers/po_controllers/view_po_basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewPOBasketScreen extends StatefulWidget {
  @override
  State<ViewPOBasketScreen> createState() => _ViewPOBasketScreenState();
}

class _ViewPOBasketScreenState extends State<ViewPOBasketScreen> {
  final POBasketController poBasketController = Get.find<POBasketController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('View PO Basket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  columns: const [
                    DataColumn(label: Text('SR NO.')),
                    DataColumn(label: Text('Item Id')),
                    DataColumn(label: Text('Venus-ID')),
                    DataColumn(label: Text('Item Name')),
                    DataColumn(label: Text('Item Group')),
                    DataColumn(label: Text('HSN Code')),
                    DataColumn(label: Text('PO Quantity')),
                    DataColumn(label: Text('Purchase UOM')),
                    DataColumn(label: Text('Delivery Date')),
                    DataColumn(label: Text('Unit Price')),
                    DataColumn(label: Text('Tax Code')),
                    DataColumn(label: Text('Tax Rate')),
                    DataColumn(label: Text('Line Total')),
                    DataColumn(label: Text('Tax Amount')),
                    DataColumn(label: Text('Final Amount')),
                    DataColumn(label: Text('Delete')),
                  ],
                  rows: poBasketController.basketItems.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item.srNo.toString())),
                      DataCell(Text(item.itemId.toString())),
                      DataCell(Text(item.venusId)),
                      DataCell(
                        Container(
                          width: 150, // Set a fixed width to avoid overflow
                          child: Text(
                            item.itemName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(Text(item.itemGroup)),
                      DataCell(Text(item.hsnCode)),
                      DataCell(Text(item.poQuantity.toString())),
                      DataCell(Text(item.uom)),
                      DataCell(Text(item.deliveryDate)),
                      DataCell(Text(item.unitPrice)),
                      DataCell(Text(item.taxCode)),
                      DataCell(Text('${item.taxRate}%')),
                      DataCell(Text(item.lineTotal.toString())),
                      DataCell(Text(item.taxAmount)),
                      DataCell(Text(item.finalAmount)),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            poBasketController.removeItemFromBasket(
                              poBasketController.basketItems.indexOf(item),
                            );
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (poBasketController.basketItems.isEmpty) {
                      Get.snackbar('Error', 'No items in the PO basket');
                      return;
                    }

                    final String poDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());

                    // Example code to submit the PO basket items
                    await poBasketController.submitPOBasket(poDate: poDate);

                    poBasketController.resetBasket();
                    setState(() {});
                  },
                  child: const Text('Submit PO'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    poBasketController.resetBasket();
                    setState(() {});
                  },
                  child: const Text('Reset Basket'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
