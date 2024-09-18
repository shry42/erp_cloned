import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/grn_models/get_po_log_by_vendorid_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetPoLogByVendoridController extends GetxController {
  var poLog = <GetPOLogByVendorIdModel>[]
      .obs; // Updated list to store UserModel objects
  var isLoading = false.obs; // Loading state

  // Method to fetch "Entry By" users
  getPoLog(int vendorID) async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/getPOLogByVendorId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          'VendorID': vendorID,
          'type': 'goods',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        List<dynamic> data = result['data'];

        // Mapping response data to UserModel list
        poLog.value =
            data.map((e) => GetPOLogByVendorIdModel.fromJson(e)).toList();
      } else {
        handleErrorResponse(response);
      }
    } catch (e) {
      print('Exception: ${e.toString()}'); // Print the exception details
      Get.snackbar('Error', 'Failed to fetch Entry By users. ${e.toString()}');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Handle error responses (e.g., validation, unauthorized)
  void handleErrorResponse(http.Response response) {
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
