import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InsertNewServicePOController extends GetxController {
  var isLoading = false;
  Future<void> insertServicePO({
    required String PODate,
    required String pRTxnID,
    required String vendorId,
    required String SupplierQuoteNo,
    required String quoteDate,
    required String rev_NO,
    required String buyerName,
    required String buyerEmailID,
    required String buyerTel,
    required String buyerMob,
    required String supplierPOCName,
    required String supplierPOCEmailID,
    required String supplierPOCTel,
    required String supplierPOCMob,
    required String deliveryTerms,
    required String paymentTerms,
    required String headerNote,
    required String approvalStatus,
    required String revisionNumber,
    required List<Map<String, dynamic>> productArr,
    PlatformFile? filePath,
  }) async {
    try {
      isLoading = true;
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      var uri = Uri.parse('${ApiService.base}/api/insertNewServicePO');

      // Convert productArr to a JSON string
      // String productArrJson = jsonEncode(productArr);
      String productArrJson = jsonEncode(productArr);

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer ${AppController.accessToken}'
        ..fields['PODate'] = '${PODate} 00:00:00:000'
        ..fields['PRTxnID'] = pRTxnID
        ..fields['VendorID'] = vendorId
        ..fields['SupplierQuoteNo'] = SupplierQuoteNo //new added
        ..fields['QuoteDate'] = '${quoteDate}'
        ..fields['BuyerName'] = buyerName
        ..fields['BuyerEmailID'] = buyerEmailID
        ..fields['BuyerTel'] = buyerTel
        ..fields['BuyerMob'] = buyerMob
        ..fields['SupplierPOCName'] = supplierPOCName
        ..fields['SupplierPOCEmailID'] = supplierPOCEmailID
        ..fields['SupplierPOCTel'] = ""
        ..fields['SupplierPOCMob'] = ""
        ..fields['DeliveryTerms'] = deliveryTerms
        ..fields['PaymentTerms'] = paymentTerms
        ..fields['HeaderNote'] = headerNote
        ..fields['ApprovalStatus'] = approvalStatus
        ..fields['RevisionNumber'] = revisionNumber
        ..fields['POTransactionServiceDetails'] = productArrJson;

      // Check if filePath is provided and valid
      if (filePath != null &&
          filePath.path != null &&
          filePath.path!.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('files', filePath.path!),
        );
      } else {
        request.fields['files'] = '';
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        isLoading = false;
        Get.back();
        Get.defaultDialog(
          title: "Success",
          middleText: "Service Purchase Order submitted successfully!",
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
        );
      } else {
        if (response.statusCode == 401) {
          toast('session expired or invalid');
          Get.offAll(LoginScreen());
        }
        Get.defaultDialog(
          title: "Error",
          middleText:
              "Failed to submit Service Purchase Order. Please try again.",
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
