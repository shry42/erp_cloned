import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/gate_entry/get_entry_log_details_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetGateEntryLogDetailsController extends GetxController {
  var getLogDetails = <GetGateEntryLogModel>[].obs;
  var isLoading = false.obs;

  getLogData() async {
    isLoading.value = true; // Start loading indicator

    try {
      http.Response response = await http.get(
        Uri.parse('${ApiService.base}/api/getEntryLog'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        if (result['data'] != null && result['data'] is List) {
          List<dynamic> data = result['data'];
          getLogDetails.value =
              data.map((e) => GetGateEntryLogModel.fromJson(e)).toList();
        } else {
          _showErrorDialog(
              "Error", "Invalid data format received from server.");
        }
      } else {
        _handleErrorResponse(response);
      }
    } catch (error) {
      _showErrorDialog("Network Error",
          "Failed to fetch data. Please check your internet connection.");
    } finally {
      isLoading.value = false; // Stop loading indicator
    }
  }

  void _handleErrorResponse(http.Response response) {
    try {
      Map<String, dynamic> result = json.decode(response.body);
      String title = result['title'] ?? "Error";
      String message = result['message'] ?? "Something went wrong";

      if (title == 'Validation Failed') {
        _showErrorDialog("Validation Failed", message);
      } else if (title == 'Unauthorized') {
        _showErrorDialog("Unauthorized", "$message \nPlease log in again.",
            reLogin: true);
      } else {
        _showErrorDialog(title, message);
      }
    } catch (error) {
      // Handle unexpected error in error response
      _showErrorDialog("Error",
          "Unexpected error occurred while processing the error response.");
    }
  }

  void _showErrorDialog(String title, String message, {bool reLogin = false}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // Close the dialog
        if (reLogin) {
          Get.offAll(LoginScreen()); // Redirect to login screen
        }
      },
    );
  }
}
