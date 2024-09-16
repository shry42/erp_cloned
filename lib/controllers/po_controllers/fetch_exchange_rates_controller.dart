import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FetchExchangeRatesController extends GetxController {
  RxInt entryId = 0.obs;
  RxDouble usdInr = 0.0.obs;
  RxDouble eurInr = 0.0.obs;
  RxDouble cnyInr = 0.0.obs;
  RxDouble jpyInr = 0.0.obs;
  RxString fetchedOn = ''.obs;

  Future<void> fetchExchangeRates() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.base}/api/fetchExchangeRate'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result['status'] == true && result['data'] != null) {
        // Accessing the 'data' field from the response
        Map<String, dynamic> data = result['data'];

        // Update the observable variables with the response data
        entryId.value = data['EntryID'] ?? 0;
        usdInr.value = data['USDINR']?.toDouble() ?? 0.0;
        eurInr.value = data['EURINR']?.toDouble() ?? 0.0;
        cnyInr.value = data['CNYINR']?.toDouble() ?? 0.0;
        jpyInr.value = data['JPYINR']?.toDouble() ?? 0.0;
        fetchedOn.value = data['FetchedOn'] ?? '';
      } else {
        // Handle case where 'status' is false or 'data' is null
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to fetch exchange rates.",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      }
    } else {
      _handleError(response);
    }
  }

  void _handleError(http.Response response) {
    Map<String, dynamic> result = json.decode(response.body);
    String title = result['title'] ?? 'Error';
    String message = result['message'] ?? 'An unexpected error occurred.';

    Get.defaultDialog(
      title: title,
      middleText: message,
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
}
