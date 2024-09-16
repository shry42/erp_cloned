import 'package:erp_copy/controllers/item_master_controller/get_item_master_list_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/add_to_basket_controller.dart';
import 'package:erp_copy/controllers/pr_controllers/insert_pr_controller.dart';
import 'package:erp_copy/model/item_master/item_master_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewBasketScreen extends StatefulWidget {
  @override
  State<ViewBasketScreen> createState() => _ViewBasketScreenState();
}

class _ViewBasketScreenState extends State<ViewBasketScreen> {
  final BasketController basketController = Get.find<BasketController>();
  final GetItemsMastersListcontroller itemsMasterController =
      Get.find<GetItemsMastersListcontroller>();
  final InsertPRController insertPRController = Get.put(InsertPRController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('View Basket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Choose files'),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  columns: const [
                    DataColumn(label: Text('SR NO.')),
                    DataColumn(label: Text('Venus Id')),
                    DataColumn(label: Text('Internal Code')),
                    DataColumn(label: Text('PR Quantity')),
                    DataColumn(label: Text('Purchase UOM')),
                    DataColumn(label: Text('Remarks')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: basketController.basketItems.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item.srNo)),
                      DataCell(Text(item.venusId)),
                      DataCell(
                        Container(
                          width: 100, // Set a fixed width to avoid overflow
                          child: Text(
                            item.internalCode,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(Text(item.quantity)),
                      DataCell(Text(item.uom)),
                      DataCell(Text(item.remark)),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            basketController.removeItemFromBasket(
                              basketController.basketItems.indexOf(item),
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
                    if (basketController.basketItems.isEmpty) {
                      Get.snackbar('Error', 'No items in the basket');
                      return;
                    }

                    final String transactionDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    final String requiredDate =
                        basketController.basketItems[0].requiredBy;

                    // Assuming all items share the same project code for simplicity
                    final String projectCode =
                        basketController.basketItems[0].venusId;

                    final productArr = basketController.basketItems.map((item) {
                      // Find the corresponding item in the items list
                      final matchedItem =
                          itemsMasterController.getItemslist.firstWhere(
                        (itm) => itm.internalCode == item.internalCode,
                        orElse: () => ItemMasterListModel(),
                      );

                      return {
                        'id': int.tryParse(item.srNo) ??
                            1, // Assuming srNo as the ID, must be an integer
                        'itemId':
                            matchedItem.itemID ?? 0, // Actual item ID, integer
                        'SAP_ID': matchedItem.sapID ?? '', // SAP ID, string
                        'item_name':
                            matchedItem.itemName ?? item.internalCode, // String
                        'quantity': item
                            .quantity, // String (could be decimal as string)
                        'UOM': item.uom, // String
                        'prNumber': int.tryParse(item.prNumber) ??
                            1, // Example field, must be an integer
                        'prDate':
                            transactionDate, // String, in 'yyyy-MM-dd' format
                        'requiredBy':
                            requiredDate, // String, in 'yyyy-MM-dd' format
                        'projectCode': item.venusId, // String
                        'remarks': item.remark, // String
                        'Internal_Code': item.internalCode, // String
                      };
                    }).toList();

// Submit the constructed payload
                    await insertPRController.insertPR(
                      transactionDate: transactionDate, // 'yyyy-MM-dd' format
                      requiredDate: requiredDate, // 'yyyy-MM-dd' format
                      projectCode: projectCode, // String
                      productArr: productArr, // List<Map<String, dynamic>>
                    );

                    basketController.resetBasket();
                    setState(() {});
                  },
                  child: const Text('Submit For Approval'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    basketController.resetBasket();
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
