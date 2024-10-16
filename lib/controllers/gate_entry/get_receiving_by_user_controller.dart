import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/gate_entry/get_receiving_by_user_model.dart';
import 'package:erp_copy/models/po_models/get_approved_po_%20model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetReceivingByUserController extends GetxController {
  var approvedPoList =
      <GetReceivingByUserModel>[].obs; // Holds the list of approved POs
  var isLoading = false.obs; // Loading state observable

  // Fetch approved POs from the API
  getReceivingUser() async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.get(
        Uri.parse('${ApiService.base}/api/getReceivingByUser'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        List<dynamic> data = result['data'];

        // Parse the response and assign it to the approved PO list
        approvedPoList.value =
            data.map((e) => GetReceivingByUserModel.fromJson(e)).toList();
      } else {
        // Handle non-200 response codes
        handleErrorResponse(response);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch approved POs.');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Handle error responses based on status code and title
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
    } else {
      Get.snackbar('Error', 'Unexpected error occurred.');
    }
  }
}
