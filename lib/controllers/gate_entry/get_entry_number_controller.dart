import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetEntryNumberController extends GetxController {
  var gateEntryNumber = ''.obs;

  Future<void> fetchEntryNumber() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.base}/api/getEntryNumber'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body) as Map<String, dynamic>;
        final data = result['data'] as Map<String, dynamic>?;

        if (data != null) {
          gateEntryNumber.value = data['getEntryNumber'].toString();
        } else {
          Get.snackbar('Error', 'No entry number found.');
        }
      } else {
        _handleErrorResponse(response);
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch entry number: $error');
    }
  }

  void _handleErrorResponse(http.Response response) {
    if (response.statusCode == 401) {
      toast('session expired or invalid');
      Get.offAll(LoginScreen());
    }

    final result = json.decode(response.body) as Map<String, dynamic>?;
    final String title = result?['title'] ?? 'Error';
    final String message = result?['message'] ?? 'An unknown error occurred';

    if (response.statusCode == 401 || title == 'Unauthorized') {
      Get.defaultDialog(
        title: "Unauthorized",
        middleText: "$message \nPlease log in again.",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.offAll(LoginScreen());
        },
      );
    } else if (title == 'Validation Failed') {
      Get.defaultDialog(
        title: "Validation Failed",
        middleText: message,
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close the dialog
        },
      );
    } else {
      Get.snackbar('Error', 'Unexpected error: $message');
    }
  }
}
