import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/po_models/get_item_details_from_txn_id_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetItemDetailsFromItemIdController extends GetxController {
  Rx<GetItemDetailsFromItemIdModel> itemDetails =
      GetItemDetailsFromItemIdModel().obs;
  List itemList = [];

  Future<void> getItemDetails(int itemID) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getItemDetailsFromItemId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "ItemID": itemID,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      // Assuming we want the first item in the list
      Map<String, dynamic> itemData = result['data'][0];
      List<dynamic> itemList = result['data'];

      // Update the observable model with the first item in the response data
      itemDetails.value = GetItemDetailsFromItemIdModel.fromJson(itemData);
      itemList = itemList
          .map((e) => GetItemDetailsFromItemIdModel.fromJson(e))
          .toList();
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
