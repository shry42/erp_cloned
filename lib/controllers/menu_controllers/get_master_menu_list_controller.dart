import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/menu_model/get_master_menu_list_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetMasterMenulistController extends GetxController {
  List<MasterMenuListModel> masterMenuList = [];
  RxList masterMenusList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getMasterMenuList(); // Automatically fetches when controller is initialized
  }

  getMasterMenuList() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.base}/api/getMasterMenuList'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];

      masterMenuList =
          data.map((e) => MasterMenuListModel.fromJson(e)).toList();

//for ui updation
      masterMenusList.value =
          data.map((e) => MasterMenuListModel.fromJson(e)).toList();

      return masterMenuList;
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
