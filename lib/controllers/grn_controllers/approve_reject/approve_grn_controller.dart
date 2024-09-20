import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApproveGrnController extends GetxController {
  Future getApprovedGRN({
    required int grnTxnID,
    required String grnRejectType,
    required String creditNoteNumber,
    required String filePath,
  }) async {
    var uri = Uri.parse('${ApiService.base}/api/approveGRN');

    var request = http.MultipartRequest('POST', uri);

    // Setting headers
    request.headers['Authorization'] = 'Bearer ${AppController.accessToken}';

    // Adding fields as form data
    request.fields['GRNTxnID'] = grnTxnID.toString();
    request.fields['type'] = 'goods';
    request.fields['GRNRejectType'] = grnRejectType;
    request.fields['creditNoteNumber'] = creditNoteNumber;

    // Add file if provided
    if (filePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('files', filePath));
    } else {
      request.fields['files'] = '';
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        String message = result['message'];
        AppController.setmessage(message);
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
        Map<String, dynamic> result = jsonDecode(response.body);
        String title = result['title'] ?? 'Error';
        String message = result['message'] ?? 'An unknown error occurred';

        Get.defaultDialog(
          title: title,
          middleText: "Status Code: ${response.statusCode}\n$message",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            if (title == 'Unauthorized') {
              Get.offAll(LoginScreen());
            } else {
              Get.back();
            }
          },
        );
      }
    } catch (e) {
      print('Exception occurred: $e');
      Get.defaultDialog(
        title: "Error",
        middleText: "An exception occurred: $e",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
