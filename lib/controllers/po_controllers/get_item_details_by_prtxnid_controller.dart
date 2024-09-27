import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/service_po_models/get_item_details_by_prtxn_id_model.dart';
import 'package:erp_copy/models/po_models/get_item_details_by_pr_txnid_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetItemDetailsByPrtxnidController extends GetxController {
  List<GetItemDetailsByPRTxnIDModel> itemlist = [];
  List<GetServiceItemDetailsByPRTxnIDModel> serviceItemList = [];

  Future getItemList(
    int PRTxnID,
  ) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getItemDetailsByPRTxnId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "PRTxnID": PRTxnID, // Dynamically use the selected item group
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];
      String? serviceData = result['type'];

      if (serviceData == 'service') {
        serviceItemList = data
            .map((e) => GetServiceItemDetailsByPRTxnIDModel.fromJson(e))
            .toList();
        return serviceItemList;
      } else {
        itemlist =
            data.map((e) => GetItemDetailsByPRTxnIDModel.fromJson(e)).toList();
        return itemlist;
      }
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
