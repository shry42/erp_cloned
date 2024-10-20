import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/menu_model/get_sub_master_menu_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetMasterSubMenulistController extends GetxController {
  List<MasterSubMenuListModel> subMasterMenuList = [];

  RxList subMenusList = [].obs;

  Future getMasterSubMenuList(int id) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getMasterSubMenuList'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "id": id,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      subMasterMenuList =
          data.map((e) => MasterSubMenuListModel.fromJson(e)).toList();

      subMenusList.value =
          data.map((e) => MasterSubMenuListModel.fromJson(e)).toList();

      return subMasterMenuList;
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
