import 'package:erp_copy/controllers/item_master_controller/get_item_master_list_controller.dart';
import 'package:erp_copy/controllers/service_pr_controllers/add_to_service_pr_basket_controller.dart';
import 'package:erp_copy/controllers/service_pr_controllers/insert_service_pr_controller.dart';
import 'package:erp_copy/model/item_master/item_master_list_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewServicePRBasketScreen extends StatefulWidget {
  @override
  State<ViewServicePRBasketScreen> createState() =>
      _ViewServicePRBasketScreenState();
}

class _ViewServicePRBasketScreenState extends State<ViewServicePRBasketScreen> {
  final ServicePRBasketController basketController =
      Get.put(ServicePRBasketController());
  final GetItemsMastersListcontroller itemsMasterController =
      Get.put(GetItemsMastersListcontroller());
  final InsertServicePRController insertServicePRController =
      Get.put(InsertServicePRController());

  List<PlatformFile> _selectedFiles = []; // List for selected files

  Future<void> _chooseFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles = result.files.length > 5
              ? result.files.sublist(0, 5)
              : result.files;
        });
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

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
              onPressed: () {
                _chooseFiles();
              },
              child: const Text('Choose files'),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  columns: const [
                    DataColumn(label: Text('SR NO.')),
                    DataColumn(label: Text('service Name')),
                    DataColumn(label: Text('Service Group')),
                    DataColumn(label: Text('PR Quantity')),
                    DataColumn(label: Text('Purchase UOM')),
                    DataColumn(label: Text('Remarks')),
                    DataColumn(label: Text('Description')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: basketController.basketItems.map((item) {
                    return DataRow(cells: [
                      DataCell(Text(item.srNo)),
                      DataCell(Text(item.serviceGroup)),
                      DataCell(
                        Container(
                          width: 100, // Set a fixed width to avoid overflow
                          child: Text(
                            item.serviceName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(Text(item.quantity)),
                      DataCell(Text(item.purchaseUOM)),
                      DataCell(Text(item.remark)),
                      DataCell(Text(item.description)),
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
                        basketController.basketItems[0].projectCode;

                    final productArr = basketController.basketItems.map((item) {
                      // Find the corresponding item in the items list
                      final matchedItem =
                          itemsMasterController.getItemslist.firstWhere(
                        (itm) => itm.purchaseUOM == item.purchaseUOM,
                        orElse: () => ItemMasterListModel(),
                      );

                      return {
                        'id': int.tryParse(item.srNo) ??
                            1, // Assuming srNo as the ID, must be an integer

                        'quantity': item
                            .quantity, // String (could be decimal as string)

                        'prNumber': int.tryParse(item.prNumber) ??
                            1, // Example field, must be an integer
                        'prDate': item.prDate,

                        'requiredBy':
                            requiredDate, // String, in 'yyyy-MM-dd' format
                        'projectCode': item.projectCode, // String
                        'Description': item.description, // String
                        'ServiceName': item.serviceName,
                        'ServiceGroup': item.serviceGroup,
                        'PurchaseUOM': item.purchaseUOM,
                        'Remarks': item.remark, // String
                      };
                    }).toList();

// Submit the constructed payload
                    await insertServicePRController.insertServicePR(
                      transactionDate: transactionDate, // 'yyyy-MM-dd' format
                      requiredDate: requiredDate, // 'yyyy-MM-dd' format
                      projectCode: projectCode, // String
                      PRTransServiceDetails:
                          productArr, // List<Map<String, dynamic>>
                      filePath: _selectedFiles.isNotEmpty
                          ? _selectedFiles.first
                          : null, // Pass the first file or null
                    );

                    basketController.resetBasket();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Submit For Approval'),
                ),
                ElevatedButton(
                  onPressed: () {
                    basketController.resetBasket();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Reset Basket'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
