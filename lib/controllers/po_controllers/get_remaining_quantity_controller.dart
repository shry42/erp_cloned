import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetRemainingQuantityController extends GetxController {
  RxInt remainingQty = 0.obs;

  Future<void> getRemainingQuantity(int PRTxnID, int itemID) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getRemainingQuantity'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "ItemID": itemID,
        "PRTxnID": PRTxnID,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      remainingQty.value = result['data']['RemainingQty'];
    } else {
      _handleError(response);
    }
  }

  void _handleError(http.Response response) {
    if (response.statusCode == 401) {
      toast('session expired or invalid');
      Get.offAll(LoginScreen());
    }
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
          Get.back();
        }
      },
    );
  }
}
