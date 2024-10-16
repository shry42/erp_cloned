import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/pr_models_new/get_single_data_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SingleDataController extends GetxController {
  SingleDataModel? singleData;

  Future<void> fetchSingleData() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.base}/api/getPRNumber'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      singleData = SingleDataModel.fromJson(result);
    } else if (response.statusCode != 200) {
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
