import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InsertGateEntryController extends GetxController {
  Future insertGateEntry({
    required int authorizerUserID,
    required String authorizerUserName,
    required String challanDate,
    required String challanNo,
    required String isPOLinked,
    required String itemCount,
    required String poCode,
    required int poID,
    required String rcvdByUser,
    required int rcvdByUserID,
    required String rcvdDate,
    required String remarks,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.base}/api/insertGateEntryLog'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: json.encode({
          "AuthorizerUserID": authorizerUserID,
          "AuthorizerUserName": authorizerUserName,
          "ChallanDate": challanDate,
          "ChallanNo": challanNo,
          "IsPOLinked": isPOLinked,
          "ItemCount": itemCount,
          "POCode": poCode,
          "POID": poID,
          "RcvdByUser": rcvdByUser,
          "RcvdByUserID": rcvdByUserID,
          "RcvdDate": rcvdDate,
          "Remarks": remarks,
        }),
      );

      final result = json.decode(response.body);

      if (response.statusCode == 200) {
        final bool? status = result['status'];
        final String message = result['message'];

        if (status == true) {
          Get.defaultDialog(
            title: "Success",
            middleText: message,
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            },
          );
        } else {
          Get.defaultDialog(
            title: "Error",
            middleText: "An unexpected error occurred.",
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            },
          );
        }
      } else {
        final title = result['title'] ?? 'Error';
        final message = result['message'] ?? 'An unexpected error occurred.';

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
            middleText: "$message \nPlease re-login",
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.offAll(LoginScreen());
            },
          );
        } else {
          Get.defaultDialog(
            title: "Error",
            middleText: message,
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            },
          );
        }
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred. Please try again later.",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
