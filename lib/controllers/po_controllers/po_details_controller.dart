import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/po_models/po_details_by_select_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class PoDetailsSelectByItemIdController {
  List<PoDetailsBySelectIdModel> poDetailsById = [];

  Future getPoDetailsById(String PoTxnId) async {
    http.Response response = await http.post(
      Uri.parse("${ApiService.base}/api/getPODetails"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: jsonEncode({"POTxnID": PoTxnId}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      AppController.setmessage(null);
      List data = result['data'];
      poDetailsById =
          data.map((e) => PoDetailsBySelectIdModel.fromJson(e)).toList();
      return poDetailsById;
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
