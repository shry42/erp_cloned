import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AmmendPoController extends GetxController {
  var isLoading = false;

  Future<void> amendPo({
    required String pdfURLLink,
    required String type,
    required String quoteDate,
    required String supplierPOCName,
    required String deliveryTerms,
    required String paymentTerms,
    required String headerNote,
    required String poTxnID,
    required List<Map<String, dynamic>> itemData,
    PlatformFile? files,
  }) async {
    try {
      isLoading = true;
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      var uri = Uri.parse('${ApiService.base}/api/POAmendment');

      // Convert itemData to a JSON string
      String itemDataJson = jsonEncode(itemData);

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer ${AppController.accessToken}'
        ..fields['pdfURLLink'] = pdfURLLink
        ..fields['type'] = type
        ..fields['QuoteDate'] = quoteDate
        ..fields['SupplierPOCName'] = supplierPOCName
        ..fields['DeliveryTerms'] = deliveryTerms
        ..fields['PaymentTerms'] = paymentTerms
        ..fields['HeaderNote'] = headerNote
        ..fields['POTxnID'] = poTxnID
        ..fields['itemData'] = itemDataJson;

      // Check if files is provided and valid
      if (files != null && files.path != null && files.path!.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('files', files.path!),
        );
      } else {
        request.fields['files'] = '';
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        isLoading = false;
        Get.back(); // Close the loading dialog
        Get.defaultDialog(
          title: "Success",
          middleText: "Purchase Order amended successfully!",
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
        );
      } else {
        if (response.statusCode == 401) {
          toast('Session expired or invalid');
          Get.offAll(LoginScreen());
        }
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to amend Purchase Order. Please try again.",
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred: $e",
        textConfirm: "OK",
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
