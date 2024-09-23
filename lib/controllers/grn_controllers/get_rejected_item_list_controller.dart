import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/grn_models/get_rejected_item_list_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetRejectedItemListController extends GetxController {
  var rejectedList =
      <GetRejectedItemListModel>[].obs; // Observed list for rejected items
  var isLoading = false.obs; // Loading state

  // Method to fetch "Rejected Items"
  getRejectedItems() async {
    isLoading(true);
    try {
      http.Response response = await http.get(
        Uri.parse('${ApiService.base}/api/getBlockedQtyRecords'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        // Print full response to check its structure
        // debugPrint('Full Response: ${result.toString()}');

        // Ensure the response has the correct structure
        if (result.containsKey('data') && result['data'] is List) {
          List<dynamic> data = result['data'];

          // Check if the second list exists and has values
          if (data.length > 1 && data[1] is List) {
            List<dynamic> secondList = data[1];

            // debugPrint('Second List Data: ${secondList.toString()}');
            if (secondList.isNotEmpty) {
              // Map the second list's items to your model
              rejectedList.value = secondList
                  .map((e) => GetRejectedItemListModel.fromJson(e))
                  .toList();
              return rejectedList;
            } else {
              debugPrint('No data found in the second list.');
              rejectedList.value = []; // Clear the list if no data
            }
          } else {
            debugPrint('Second list is missing or empty.');
            rejectedList.value = []; // Clear the list if structure is invalid
          }
        } else {
          debugPrint('Invalid response structure.');
          rejectedList.value = []; // Clear the list if structure is invalid
        }
      } else {
        handleErrorResponse(response); // Handle HTTP errors
      }
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      Get.snackbar('Error', 'Failed to fetch rejected items. ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // Handle error responses (e.g., validation, unauthorized)
  void handleErrorResponse(http.Response response) {
    Map<String, dynamic> result = json.decode(response.body);
    String title =
        result['title'] ?? 'Error'; // Default to 'Error' if title is missing
    String message =
        result['message'] ?? 'Something went wrong'; // Default message

    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // Close the dialog
      },
    );

    // Handle unauthorized or token expiry (optional)
    if (response.statusCode == 401) {
      // Redirect to login or refresh token logic
      Get.offAll(LoginScreen());
    }
  }
}
