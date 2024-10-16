import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InsertDataController extends GetxController {
  Future<void> insertData({
    required String itemName,
    required String sapId,
    required String casNo,
    required String internalCode,
    String? category,
    required String hsnCode,
    required int inventoryItem,
    required String inventoryUom,
    required String itemGroup,
    required int itemsPerPurchase,
    required String itemsPerSales,
    required int manageBatch,
    required int purchaseItem,
    required String purchaseUom,
    required int qaManagement,
    required String safetyStock,
    required int salesItem,
    required String salesUom,
    required int serialManagement,
    required String threshold,
    required String valuationMethod,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiService.base}/api/insertData'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "Item_Name": itemName,
        "SAP_ID": sapId,
        "CAS_No": casNo,
        "Internal_Code": internalCode,
        "Category": category,
        "HSN_Code": hsnCode,
        "Inventory_Item": inventoryItem,
        "Inventory_UOM": inventoryUom,
        "Item_Group": itemGroup,
        "Items_per_Purchase": itemsPerPurchase,
        "Items_per_Sales": itemsPerSales,
        "Manage_Batch": manageBatch,
        "Purchase_Item": purchaseItem,
        "Purchase_UOM": purchaseUom,
        "QAManagement": qaManagement,
        "SafetyStock": safetyStock,
        "Sales_Item": salesItem,
        "Sales_UOM": salesUom,
        "Serial_Management": serialManagement,
        "Threshold": threshold,
        "Valuation_Method": valuationMethod,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String message = result['message'];

      if (status == true) {
        toast(message);
      }
    } else {
      if (response.statusCode == 401) {
        toast('session expired or invalid');
        Get.offAll(LoginScreen());
      }
      Map<String, dynamic> result = json.decode(response.body);
      String title = result['title'];
      String message = result['message'];

      if (title == 'Validation Failed') {
        Get.defaultDialog(
          title: "Error",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
        );
        toast(message);
      } else if (title == 'Unauthorized') {
        Get.defaultDialog(
          title: "Error",
          middleText: "$message \nplease re login",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(LoginScreen());
            // Get.back(); // Close the dialog
          },
        );
        toast('$message\n please re login');
      }
    }
  }
}
