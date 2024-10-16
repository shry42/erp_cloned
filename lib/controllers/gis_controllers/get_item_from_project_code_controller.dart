import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/gis_model/get_item_from_project_code_model.dart';
import 'package:erp_copy/model/gis_model/get_user_details_from_pcode_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetItemFromProjectCodeController extends GetxController {
  var itemlist = <GetItemFromProjectCodeModel>[].obs; // Use RxList
  var userList = <GetUserDetailsFromPcodemodel>[].obs;

  getItemList(String? projectCode) async {
    http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/getItemUsingProjectCode'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          "projectCode": projectCode,
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];
      List<dynamic> userData = result['userDetails'];

      itemlist.value =
          data.map((e) => GetItemFromProjectCodeModel.fromJson(e)).toList();

      userList.value = userData
          .map((e) => GetUserDetailsFromPcodemodel.fromJson(e))
          .toList();

      return itemlist;
    } else if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        toast('session expired or invalid');
        Get.offAll(LoginScreen());
      }
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
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
          middleText: "$message \nplease re login",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(LoginScreen());
            // Get.back(); // Close the dialog
          },
        );
      }
    }
  }
}
