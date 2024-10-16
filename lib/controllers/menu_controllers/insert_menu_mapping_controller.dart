import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MenuMapping {
  final int menuId;
  final int subMenuId;

  MenuMapping({required this.menuId, required this.subMenuId});

  Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "subMenuId": subMenuId,
      };
}

class InsertMenuMappingController extends GetxController {
  Future<void> insertUserMenuMapping(
      String userId, List<MenuMapping> menuMappings) async {
    try {
      // Convert menuMappings to JSON string format as required
      String menuListJson =
          json.encode(menuMappings.map((mapping) => mapping.toJson()).toList());

      // Prepare the request body according to the required format
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "menuList": menuListJson, // This will be a JSON string
      };

      // Make the API call
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/insertUserMenuMapping'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: json.encode(requestBody),
      );

      // Handle the response
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        bool? status = result['status'];
        String message = result['message'];

        Get.defaultDialog(
          title: "Success",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
        );
      } else {
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
              Get.back();
            },
          );
        } else if (title == 'Unauthorized') {
          Get.defaultDialog(
            title: "Error",
            middleText: "$message\nPlease re-login",
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.offAll(LoginScreen());
            },
          );
        }
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred while processing your request",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  // Example usage method
  void submitMenuMappings(String userId, List<MenuMapping> mappings) {
    // Example of how to use:
    // List<MenuMapping> mappings = [
    //   MenuMapping(menuId: 30, subMenuId: 44),
    // ];
    // submitMenuMappings("12", mappings);

    insertUserMenuMapping(userId, mappings);
  }
}
