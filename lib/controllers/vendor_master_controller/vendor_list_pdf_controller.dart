import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/model/vendor_master/vendor_master_list_pdf_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetVendorMasterPdfController extends GetxController {
  List<VendorMasterListPdfModel> getVednorPdf = [];
  final RxList<VendorMasterListPdfModel> vendorPdfList =
      <VendorMasterListPdfModel>[].obs;

  getVednorMaster(int txnid, String IDType, {bool? showPdf = false}) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getFiles'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "IDType": IDType,
        "TxnID": txnid,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<dynamic> data = result['data'];
      final fileName = data[0]['StoredFileName'];
      final filePath = data[0]['FilePath'];

      getVednorPdf =
          data.map((e) => VendorMasterListPdfModel.fromJson(e)).toList();

      vendorPdfList.value =
          data.map((e) => VendorMasterListPdfModel.fromJson(e)).toList();
      if (showPdf == false) {
        Get.defaultDialog(
            title: 'Pdf',
            middleText: fileName,
            confirm: ElevatedButton(
                onPressed: () {
                  Get.to(PdfViewerScreen(filePath: filePath));
                },
                child: const Text('view pdf')));
      }

      return getVednorPdf;
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
