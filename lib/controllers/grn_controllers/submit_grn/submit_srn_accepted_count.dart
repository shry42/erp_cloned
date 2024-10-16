import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubmitSrnAcceptedCountController extends GetxController {
  var isLoading = false.obs; // Loading state

  Future submitSRN(int GRNTxnID, List<Map<String, dynamic>> GRNData) async {
    isLoading(true); // Start loading
    try {
      // Create the GRNData JSON string
      String grnDataJson = jsonEncode(GRNData);

      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/submitSGRNAcceptedCount'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          "GRNTxnID": GRNTxnID,
          "GRNData": grnDataJson, // Include the GRNData as a JSON string
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        // String status = result['status'];
        String message = result['message'];

        // Show a success message dialog
        Get.defaultDialog(
          title: 'Success',
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
        );
      } else {
        handleErrorResponse(response);
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
      Get.snackbar('Error', 'Failed to submit GRN. ${e.toString()}');
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
