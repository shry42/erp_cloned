import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InsertPRController extends GetxController {
  Future<void> insertPR({
    required String transactionDate,
    required String requiredDate,
    required String projectCode,
    required List<Map<String, dynamic>> productArr,
    PlatformFile? filePath,
  }) async {
    try {
      var uri = Uri.parse('${ApiService.base}/api/insertPR');

      // Convert productArr to a JSON string
      String productArrJson = jsonEncode(productArr);
      // Add file if provided

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer ${AppController.accessToken}'
        ..fields['transactiondate'] = transactionDate
        ..fields['RequiredDate'] = requiredDate
        ..fields['ProjectCode'] = projectCode
        ..fields['productArr'] = productArrJson; // Stringify the productArr

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

      var response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful insert
        Get.defaultDialog(
          title: "Success",
          middleText: "Purchase Request submitted successfully!",
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
        );
      } else {
        // Handle error responses
        Get.defaultDialog(
          title: "Error",
          middleText: "Failed to submit Purchase Request. Please try again.",
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      // Handle any other errors
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
