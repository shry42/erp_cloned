import 'dart:convert';

import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/vendor_master/get_ifsc_code_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../services/api_service.dart';

class GetIFSCCodeController extends GetxController {
  GetIFSCModel? ifscDetails;

  Future getIFSC(String ifscCode) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getIFSCCode'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "ifscCode": ifscCode,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result['status'] == true && result['data'] != null) {
        // Assuming the data field is a Map and has the relevant details
        ifscDetails = GetIFSCModel.fromJson(result['data']);
      } else {
        ifscDetails = null; // No data found, handle accordingly
      }

      return ifscDetails;
    } else {
      // Handle errors here (e.g., unauthorized, validation errors)
      Map<String, dynamic> result = json.decode(response.body);
      String title = result['title'];
      String message = result['message'];

      if (title == 'Validation Failed') {
        Get.defaultDialog(
          title: "Error",
          middleText: "$message",
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
