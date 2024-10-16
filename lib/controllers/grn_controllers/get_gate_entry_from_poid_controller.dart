import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/grn_models/get_gate_entry_from_poid_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetGateEntryFromPoidController extends GetxController {
  var gateEntryNos =
      <GetGateEntryNumberFromPoIDModel>[].obs; // List to store PO items
  var isLoading = false.obs; // Loading state

  // Method to fetch PO items
  Future<void> getGateEntryFromPOID(int pOId) async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/getGateEntryFromPOId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          'POId': pOId,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        List<dynamic> data = result['data'];

        // Mapping response data to GetPOItemsModel list
        gateEntryNos.value = data
            .map((e) => GetGateEntryNumberFromPoIDModel.fromJson(e))
            .toList();
      } else {
        handleErrorResponse(response);
      }
    } catch (e) {
      print('Exception: ${e.toString()}'); // Print the exception details
      Get.snackbar('Error', 'Failed to fetch PO items. ${e.toString()}');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Handle error responses (e.g., validation, unauthorized)
  void handleErrorResponse(http.Response response) {
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
    } else if (title == 'Unauthorized') {
      Get.defaultDialog(
        title: "Error",
        middleText: "$message \nPlease re-login",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.offAll(LoginScreen()); // Redirect to login
        },
      );
    }
  }
}
