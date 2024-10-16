import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/grn_models/grn_rejected_list_inside_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GrnRejectedListInsideController extends GetxController {
  var grnRejectedList = <GRNRejectedListInsideModel>[]
      .obs; // Updated list to store UserModel objects
  var isLoading = false.obs; // Loading state

  // Method to fetch "Entry By" users
  getRejectedList(int GRNTxnID) async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/getBlockedQtyDetails'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          'GRNTxnID': GRNTxnID,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        List<dynamic> data = result['data'];

        // Mapping response data to UserModel list
        grnRejectedList.value =
            data.map((e) => GRNRejectedListInsideModel.fromJson(e)).toList();
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
