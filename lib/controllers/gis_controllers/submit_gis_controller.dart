import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SubmitGisController extends GetxController {
  Future submitGIS({
    required String department,
    required List<Map<String, dynamic>> gisTransactionDetails,
    required String issuedTo,
    required String projectCode,
    required String txnDate,
    int woTxnID = 0,
    String type = "GIS",
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.base}/api/insertNewGISTransaction'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: json.encode({
          "Department": department,
          "GISTransactionDetails": json.encode(gisTransactionDetails),
          "IssuedTo": issuedTo,
          "ProjectCode": projectCode,
          "TxnDate": txnDate,
          "WOTxnID": woTxnID,
          "type": type,
        }),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == true) {
          toast(result['message']);
        } else {
          _showErrorDialog("Error", result['message']);
        }
      } else {
        final result = json.decode(response.body);
        if (result['title'] == 'Validation Failed') {
          _showErrorDialog("Error", result['message']);
        } else if (result['title'] == 'Unauthorized') {
          _showUnauthorizedDialog(result['message']);
        } else {
          _showErrorDialog("Error", "An unexpected error occurred");
        }
      }
    } catch (e) {
      _showErrorDialog("Error", "An unexpected error occurred: $e");
    }
  }

  void _showErrorDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
    toast(message);
  }

  void _showUnauthorizedDialog(String message) {
    Get.defaultDialog(
      title: "Error",
      middleText: "$message\nPlease re-login",
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.offAll(() => LoginScreen()),
    );
    toast('$message\nPlease re-login');
  }
}
