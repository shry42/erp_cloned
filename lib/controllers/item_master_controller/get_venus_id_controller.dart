import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetVenusIdController extends GetxController {
  String? venusId;

  Future<void> getVenusid(String itemGroup) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getVenusId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "itemGroup": itemGroup, // Dynamically use the selected item group
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      venusId = result['data'];
      update(); // Notify listeners to update UI
    } else {
      _handleError(response);
    }
  }

  void _handleError(http.Response response) {
    Map<String, dynamic> result = json.decode(response.body);
    String title = result['title'];
    String message = result['message'];

    Get.defaultDialog(
      title: "Error",
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (title == 'Unauthorized') {
          Get.offAll(LoginScreen());
        } else {
          Get.back(); // Close the dialog
        }
      },
    );
  }
}
