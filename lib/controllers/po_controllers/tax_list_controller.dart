import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/po_models/tax_list_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaxListController extends GetxController {
  var taxList = <TaxListModel>[].obs; // Use RxList for reactivity

  Future getTaxList(int vendorId) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/taxList'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "VendorID": vendorId,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];
      taxList.value = data
          .map((e) => TaxListModel.fromJson(e))
          .toList(); // Update the reactive list
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
