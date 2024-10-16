import 'package:erp_copy/controllers/stock_posting_controllers/stock_movement_controllers/stock_movement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:erp_copy/controllers/stock_posting_controllers/stock_movement_controllers/get_item_from_master_stock_controller.dart';
import 'package:erp_copy/controllers/stock_posting_controllers/stock_movement_controllers/get_item_from_stock_breakup_controller.dart';
import 'package:erp_copy/model/stock_posting/stock_movement/get_items_from_master_stock_model.dart';
import 'package:erp_copy/widget/menu_widget/drawer_menu_widget.dart';

class StockMovementScreen extends StatefulWidget {
  final VoidCallback openDrawer;

  StockMovementScreen({Key? key, required this.openDrawer}) : super(key: key);

  @override
  State<StockMovementScreen> createState() => _StockMovementScreenState();
}

class _StockMovementScreenState extends State<StockMovementScreen> {
  final stockMovementController = Get.put(StockMovementController());

  final GetItemFromStockBreakupController gifsbc =
      Get.put(GetItemFromStockBreakupController());

  final formKey = GlobalKey<FormState>();

  final TextEditingController unRestrictedText = TextEditingController();

  final TextEditingController serialnoText = TextEditingController();

  final TextEditingController batchnoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Stock Movement'),
        backgroundColor: const Color.fromARGB(255, 29, 169, 32),
        actions: [
          DrawerMenuWidget(onClicked: widget.openDrawer),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildVendorDetailsSection(),
              const SizedBox(height: 30),
              _buildMovementFields(),
              const SizedBox(height: 10),
              _buildSelectedItemFields(),
              const SizedBox(height: 10),
              _buildButtonsTabBarSection(),
              const SizedBox(height: 20),
              buildElevatedFormButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorDetailsSection() {
    return GetX<GetItemFromMasterStockController>(
      builder: (controller) {
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<GetItemsFromMasterStockModel>(
                value: stockMovementController.selectedItemName.value,
                dropdownColor: Colors.white,
                isDense: true,
                isExpanded: true,
                menuMaxHeight: 400,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  labelStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  constraints: const BoxConstraints(maxHeight: 45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                items: controller.itemList.map((item) {
                  return DropdownMenuItem<GetItemsFromMasterStockModel>(
                    value: item,
                    child: Text(
                      item.itemName ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    stockMovementController.selectedItemName.value = value;
                    stockMovementController
                        .getItemStockData(value.itemID!.toInt());
                    setState(() {});
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.blueGrey),
              onPressed: _showItemDetailsDialog,
              constraints: const BoxConstraints(minWidth: 40),
            ),
          ],
        );
      },
    );
  }

  void _showItemDetailsDialog() {
    if (stockMovementController.selectedItemName.value != null) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Obx(() {
            final itemStockController =
                stockMovementController.itemStockController;

            // Calculate total unrestricted stock
            double pilotStock = itemStockController.psStockList.isNotEmpty
                ? double.tryParse(itemStockController
                        .psStockList[0].unrestrictedStock
                        .toString()) ??
                    0.0
                : 0.0;

            double rndStock = itemStockController.rdStockList.isNotEmpty
                ? double.tryParse(itemStockController
                        .rdStockList[0].unrestrictedStock
                        .toString()) ??
                    0.0
                : 0.0;

            double warehouseStock = itemStockController.whStockList.isNotEmpty
                ? double.tryParse(itemStockController
                        .whStockList[0].unrestrictedStock
                        .toString()) ??
                    0.0
                : 0.0;

            double totalUnrestrictedStock =
                pilotStock + rndStock + warehouseStock;

            String uom = itemStockController.itemDetailsList.isNotEmpty
                ? itemStockController.itemDetailsList[0].purchaseUOM ?? 'N/A'
                : 'N/A';

            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Item Details',
                  style: TextStyle(color: Colors.black)),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDialogTextField('Total Un-Restricted Stock Available',
                        totalUnrestrictedStock.toString()),
                    _buildDialogTextField('UOM', uom),
                    _buildDialogTextField('Pilot Store', pilotStock.toString()),
                    _buildDialogTextField('RnD Store', rndStock.toString()),
                    _buildDialogTextField(
                        'Warehouse', warehouseStock.toString()),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Close',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
        },
      );
    }
  }

  Widget _buildDialogTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildMovementFields() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) =>
                    stockMovementController.movementQuantityText.value = value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Movement Quantity',
                  labelStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  constraints: const BoxConstraints(maxHeight: 45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter movement quantity';
                  }
                  final number = double.tryParse(value!);
                  if (number == null) return 'Please enter a valid number';
                  if (number <= 0) return 'Quantity must be greater than 0';

                  final availableStock = double.tryParse(stockMovementController
                          .selectedUnrestrictedStock.value) ??
                      0;
                  if (number > availableStock) {
                    return 'Quantity cannot exceed available stock';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                value: stockMovementController.selectedTargetLocation.value,
                decoration: InputDecoration(
                  labelText: 'Target Location',
                  labelStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  constraints: const BoxConstraints(maxHeight: 45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                      value: 'Pilot Store',
                      child: Text(
                        'Pilot Store',
                        style: TextStyle(color: Colors.black),
                      )),
                  DropdownMenuItem(
                      value: 'Rnd Store',
                      child: Text(
                        'Rnd Store',
                        style: TextStyle(color: Colors.black),
                      )),
                  DropdownMenuItem(
                      value: 'WareHouse',
                      child: Text(
                        'WareHouse',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
                onChanged: (String? newValue) =>
                    stockMovementController.updateTargetLocation(
                  newValue,
                  stockMovementController.selectedTab.value,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select target location';
                  }
                  return null;
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildSelectedItemFields() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selected Item Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: unRestrictedText,
                  // initialValue:
                  //     stockMovementController.unrestrictedStockText.value,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Un-Restricted Stock',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: batchnoText,
                  // initialValue: stockMovementController.batchNoText.value,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Batch No',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: serialnoText,
                  // initialValue: stockMovementController.serialNoText.value,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Serial No',
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButtonsTabBarSection() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          ButtonsTabBar(
            backgroundColor: Colors.blue,
            unselectedBackgroundColor: Colors.grey[300],
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            onTap: (index) {
              stockMovementController.selectedTab.value = index;
              stockMovementController.clearSelection();
            },
            tabs: const [
              Tab(text: 'Pilot Stores'),
              Tab(text: 'RnD Stores'),
              Tab(text: 'WareHouse'),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 310,
            child: TabBarView(
              children: [
                _buildStockStoreSection(StoreType.pilot),
                _buildStockStoreSection(StoreType.rnd),
                _buildStockStoreSection(StoreType.warehouse),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockStoreSection(StoreType storeType) {
    return GetX<GetItemFromStockBreakupController>(
      builder: (controller) {
        final List dataToShow;
        switch (storeType) {
          case StoreType.pilot:
            dataToShow = controller.psStockList;
            break;
          case StoreType.rnd:
            dataToShow = controller.rdStockList;
            break;
          case StoreType.warehouse:
            dataToShow = controller.whStockList;
            break;
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey.shade300),
              dataRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              dividerThickness: 1,
              columns: const [
                DataColumn(
                    label: Text('Venus ID',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('Batch No',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('Serial No',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('Internal Code',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('Item Group',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('Unrestricted Stock',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('QA Stock',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('Blocked Stock',
                        style: TextStyle(color: Colors.black))),
                DataColumn(
                    label: Text('Purchase UOM',
                        style: TextStyle(color: Colors.black))),
              ],
              rows: dataToShow.map((stockItem) {
                final rowId =
                    '${stockItem.serialNo}-${stockItem.batchNo}-${stockItem.internalCode}';
                return DataRow(
                  selected:
                      stockMovementController.selectedRowId.value == rowId,
                  onSelectChanged: (isSelected) {
                    if (isSelected ?? false) {
                      stockMovementController.updateSelectedRow(
                        rowId,
                        stockItem.unrestrictedStock?.toString() ?? '',
                        stockItem.batchNo ?? '',
                        stockItem.serialNo ?? '',
                      );
                      unRestrictedText.text =
                          stockItem.unrestrictedStock?.toString() ?? '';
                      batchnoText.text = stockItem.batchNo ?? '';
                      serialnoText.text = stockItem.serialNo ?? '';
                    }
                  },
                  cells: [
                    DataCell(Text(
                      stockMovementController.selectedVenusid.value,
                      style: const TextStyle(color: Colors.black),
                    )),
                    DataCell(Text(stockItem.batchNo ?? '',
                        style: const TextStyle(color: Colors.black))),
                    DataCell(Text(stockItem.serialNo ?? '',
                        style: const TextStyle(color: Colors.black))),
                    DataCell(Text(stockItem.internalCode ?? '',
                        style: const TextStyle(color: Colors.black))),
                    DataCell(Text(stockItem.itemGroup ?? '',
                        style: const TextStyle(color: Colors.black))),
                    DataCell(Text(stockItem.unrestrictedStock?.toString() ?? '',
                        style: const TextStyle(color: Colors.black))),
                    DataCell(Text(stockItem.qaStock?.toString() ?? '',
                        style: const TextStyle(color: Colors.black))),
                    DataCell(Text(stockItem.blockedStock?.toString() ?? '',
                        style: const TextStyle(color: Colors.black))),
                    DataCell(Text(stockItem.purchaseUOM ?? '',
                        style: const TextStyle(color: Colors.black))),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget buildElevatedFormButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (gifsbc.isActive != 2) {
            stockMovementController.submitInternalItemTransfer();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: gifsbc.isActive == 2
              ? Colors.blue
              : Colors.red, // Dynamic color change
          padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 18), // Larger padding for a more prominent button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                8), // Slightly less round corners for a sharper look
            side: BorderSide(
                color: Colors.grey.shade300,
                width: 2), // Light border to give it depth
          ),
          elevation:
              6, // Slightly higher elevation for a stronger shadow effect
          shadowColor: Colors.black.withOpacity(0.2), // Light shadow color
        ),
        child: Obx(() {
          return Text(
            gifsbc.isActive == 2
                ? 'This item is blocked'
                : 'Transfer this item',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text for contrast
              letterSpacing: 1.2, // Slightly spaced-out letters for readability
            ),
          );
        }),
      ),
    );
  }
}
