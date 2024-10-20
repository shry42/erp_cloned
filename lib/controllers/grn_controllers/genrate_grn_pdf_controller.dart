import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/screens/pdf_view_screen/pdf_view_screen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GenrateGrnPdfController extends GetxController {
  var isLoading = false.obs; // Loading variable

  Future generateGRNPdf(int GRNTxnID) async {
    isLoading.value = true; // Set loading to true before showing the dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      isLoading.value = true; // Set loading to true before starting the request
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/getGRNPDF'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: json.encode({
          "GRNTxnID": GRNTxnID,
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
            middleText: "PDF generated successfully",
            textConfirm: "View",
            confirmTextColor: Colors.white,
            onConfirm: () {
              if (pdfUrl != null) {
                Get.to(() => PdfViewerScreen(filePath: pdfUrl));
              }
            },
          );
        }
      } else {
        if (response.statusCode == 401) {
          toast('session expired or invalid');
          Get.offAll(LoginScreen());
        }
        Map<String, dynamic> result = json.decode(response.body);
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
            },
          );
        }
      }
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "An error occurred while generating the PDF.",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back(); // Close the dialog
        },
      );
    } finally {
      isLoading.value = false; // Set loading to false after request completes
    }
  }
}
