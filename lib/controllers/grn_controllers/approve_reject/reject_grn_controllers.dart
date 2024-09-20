import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RejectGrnControllers extends GetxController {
  var isLoading = false.obs; // Loading state

  // Method to fetch PO items
  Future rejectGRN(int GRNTxnID) async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/rejectGRN'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          "GRNTxnID": GRNTxnID,
          "type": "goods",
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        String message = result['message'];
        AppController.setmessage(message);
        Get.defaultDialog(
          title: "Success",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        String title = result['title'] ?? 'Error';
        String message = result['message'] ?? 'An unknown error occurred';

        Get.defaultDialog(
          title: title,
          middleText: "Status Code: ${response.statusCode}\n$message",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            if (title == 'Unauthorized') {
              Get.offAll(LoginScreen());
            } else {
              Get.back();
            }
          },
        );
      }
    } catch (e) {
      print('Exception occurred: $e');
      Get.defaultDialog(
        title: "Error",
        middleText: "An exception occurred: $e",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
