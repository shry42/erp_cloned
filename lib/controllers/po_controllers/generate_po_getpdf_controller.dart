import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GeneratePOGetPdfController extends GetxController {
  var isLoading = false.obs; // Loading variable

  Future generatePO(int pOTxniD) async {
    isLoading.value = true; // Set loading to true before showing the dialog
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getPdfDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "POTxnID": pOTxniD,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];

      String? pdfUrl = result['data'];

      if (status == true) {
        isLoading.value = false;
        Get.back(); // Close the loading dialog
        Get.defaultDialog(
          title: "Success",
          middleText: "Pdf generated succesfully",
          textConfirm: "View",
          confirmTextColor: Colors.white,
          onConfirm: () {
            if (pdfUrl != null) {
              Get.to(() => PdfViewerScreen(filePath: pdfUrl));
            }
          },
        );
      }
    } else if (response.statusCode != 200) {
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
          middleText: "$message \nplease re-login",
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
