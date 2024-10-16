import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/controllers/stock_posting_controllers/stock_movement_controllers/get_item_from_master_stock_controller.dart';
import 'package:erp_copy/controllers/stock_posting_controllers/stock_movement_controllers/get_item_from_stock_breakup_controller.dart';
import 'package:erp_copy/model/stock_posting/stock_movement/get_items_from_master_stock_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum StoreType { pilot, rnd, warehouse }

class StockMovementController extends GetxController {
  final selectedTargetLocation = Rx<String?>(null);
  final selectedTab = 0.obs;
  final selectedRowId = Rx<String?>(null);
  final selectedBatchNo = ''.obs;
  final selectedSerialNo = ''.obs;
  final selectedUnrestrictedStock = ''.obs;
  final selectedVenusid = ''.obs;
  final selectedItemName = Rx<GetItemsFromMasterStockModel?>(null);

  // Text fields as observables
  final movementQuantityText = ''.obs;
  final unrestrictedStockText = ''.obs;
  final batchNoText = ''.obs;
  final serialNoText = ''.obs;

  // GetX Controllers
  final GetItemFromMasterStockController itemNameController =
      Get.put(GetItemFromMasterStockController());
  final GetItemFromStockBreakupController itemStockController =
      Get.put(GetItemFromStockBreakupController());

  @override
  void onInit() {
    super.onInit();
    itemNameController.getItemsfromMasterstock();
  }

  Future<void> getItemStockData(int itemId) async {
    await itemStockController.getItemstockBrkp(itemId);
    selectedVenusid.value = itemStockController.selectedVenusid.toString();
  }

  void updateSelectedRow(
      String rowId, String unrestrictedStock, String batchNo, String serialNo) {
    selectedRowId.value = rowId;
    selectedUnrestrictedStock.value = unrestrictedStock;
    selectedBatchNo.value = batchNo;
    selectedSerialNo.value = serialNo;

    // Update the text fields
    unrestrictedStockText.value = unrestrictedStock;
    batchNoText.value = batchNo;
    serialNoText.value = serialNo;
  }

  void clearSelection() {
    selectedRowId.value = null;
    selectedUnrestrictedStock.value = '';
    selectedBatchNo.value = '';
    selectedSerialNo.value = '';

    // Clear text fields
    unrestrictedStockText.value = '';
    batchNoText.value = '';
    serialNoText.value = '';
  }

  void updateTargetLocation(String? newLocation, int currentTab) {
    if (newLocation != null) {
      if ((currentTab == 0 && newLocation == 'Pilot Store') ||
          (currentTab == 1 && newLocation == 'Rnd Store') ||
          (currentTab == 2 && newLocation == 'WareHouse')) {
        Get.snackbar(
          'Error',
          'Cannot select current location as target',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      selectedTargetLocation.value = newLocation;
    }
  }

  Future<void> submitInternalItemTransfer() async {
    if (selectedItemName.value == null ||
        selectedTargetLocation.value == null ||
        movementQuantityText.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final url = Uri.parse('${ApiService.base}/api/internalItemTransfer');

    // Get the current stock list based on the selected tab
    final currentStockList = _getCurrentStockList();

    // Find the selected item in the current stock list
    final selectedStock = currentStockList.firstWhereOrNull(
      (stock) =>
          stock.batchNo == selectedBatchNo.value &&
          stock.serialNo == selectedSerialNo.value,
    );

    if (selectedStock == null) {
      Get.snackbar(
        'Error',
        'Selected item not found in current stock list',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Prepare the productArray as a list of items
    final productArray = [
      {
        'ItemID': selectedItemName.value!.itemID,
        'ItemName': selectedItemName.value!.itemName,
        'BatchNo': selectedBatchNo.value,
        'SerialNo': selectedSerialNo.value,
        'InternalCode': selectedStock.internalCode,
        'ItemGroup': selectedStock.itemGroup,
        'PurchaseUOM': selectedStock.purchaseUOM,
        'PostDate': DateTime.now().toIso8601String(),
        'Qty': double.parse(movementQuantityText.value),
      }
    ];

    // Stringify the productArray
    final productArrayString = json.encode(productArray);

    // Define the payload, with the productArray as a string
    final payload = {
      'SourceTable': _getSourceTable(selectedTab.value),
      'TargetTable': _getTargetTable(selectedTargetLocation.value!),
      'productArray': productArrayString, // Passed as a string
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: json.encode(payload), // json.encode for the final payload
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Item transferred successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        clearSelection(); // Clear form or update UI as needed
      } else if (response.statusCode == 401) {
        toast('session expired or invalid');
        Get.offAll(LoginScreen());
      } else {
        Get.snackbar(
          'Error',
          'Failed to transfer item: ${response.body}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  List<dynamic> _getCurrentStockList() {
    switch (selectedTab.value) {
      case 0:
        return itemStockController.psStockList;
      case 1:
        return itemStockController.rdStockList;
      case 2:
        return itemStockController.whStockList;
      default:
        return [];
    }
  }

  String _getSourceTable(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return 'PSStockList';
      case 1:
        return 'RDStockList';
      case 2:
        return 'WHStockList';
      default:
        return '';
    }
  }

  String _getTargetTable(String targetLocation) {
    switch (targetLocation) {
      case 'Pilot Store':
        return 'PSStockList';
      case 'Rnd Store':
        return 'RDStockList';
      case 'WareHouse':
        return 'WHStockList';
      default:
        return '';
    }
  }
}
