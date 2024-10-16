import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/grn_models/submit_grn/service_grn_transac_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InsertServiceGRNTransactionController extends GetxController {
  Future<void> insertServiceGRNTransaction({
    required String transactionDate,
    required int focSampleFlag,
    required String remarks,
    required String invoiceNo,
    required String invoiceDate,
    required String challanNo,
    required List<ServiceGRNTransactionDetailsModel> transactionDetails,
    required PlatformFile? filePath,
  }) async {
    try {
      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiService.base}/api/insertServiceGRNTransaction'),
      );

      // Add form fields
      request.fields['transactiondate'] = transactionDate;
      request.fields['FOCSampleFlag'] = focSampleFlag.toString();
      request.fields['remarks'] = remarks;
      request.fields['InvoiceNo'] = invoiceNo;
      request.fields['InvoiceDate'] = invoiceDate;
      request.fields['challanNo'] = challanNo;

      // Convert the list of GRNTransactionDetails to JSON and add as a form field
      request.fields['TransactionDetails'] =
          json.encode(transactionDetails.map((e) => e.toJson()).toList());

      // Add files to the request, ensuring they are properly attached
      // Check if filePath is provided and valid
      if (filePath != null &&
          filePath.path != null &&
          filePath.path!.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
              'files', filePath.path!), // Use filePath.path
        );
      } else {
        request.fields['files'] = '';
      }

      // Add authorization header
      request.headers['Authorization'] = 'Bearer ${AppController.accessToken}';

      // Send request and handle response
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final result = json.decode(responseBody);

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
        if (response.statusCode == 401) {
          toast('session expired or invalid');
          Get.offAll(LoginScreen());
        }
        final title = result['title'] ?? 'Error';
        final message = result['message'] ?? 'An unexpected error occurred.';

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
