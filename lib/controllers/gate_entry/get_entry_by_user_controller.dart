import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/gate_entry/get_entry_by_user_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetEntryByUserController extends GetxController {
  var entryByUsers =
      <GetEntryByUserModel>[].obs; // Updated list to store UserModel objects
  var isLoading = false.obs; // Loading state

  // Method to fetch "Entry By" users
  fetchEntryByUsers() async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.get(
        Uri.parse('${ApiService.base}/api/getEntryByUser'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        List<dynamic> data = result['data'];

        // Mapping response data to UserModel list
        entryByUsers.value =
            data.map((e) => GetEntryByUserModel.fromJson(e)).toList();
      } else {
        // Handle other status codes with appropriate messages
        handleErrorResponse(response);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch Entry By users.');
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
