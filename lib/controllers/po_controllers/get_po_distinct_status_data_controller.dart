import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/po_models/get_po_distinct_status_data_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetPODistinctStatusDataController extends GetxController {
  var poDistinctDataList = <GetPODistinctStatusDataModel>[].obs;
  List<GetPODistinctStatusDataModel> initialPoDistinctDataList = [];

  Future getPODistinctStatus() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.base}/api/getPODistinctStatusData'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      // Populate both the observable list and the initial list
      poDistinctDataList.value =
          data.map((e) => GetPODistinctStatusDataModel.fromJson(e)).toList();
      initialPoDistinctDataList = List.from(poDistinctDataList);
    } else {
      // Handle error cases
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
          middleText: "$message \nplease re-login",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(LoginScreen());
          },
        );
      }
    }
  }
}
