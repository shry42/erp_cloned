import 'dart:convert';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/services/api_service.dart';

class AllocateStockPostingController extends GetxController {
  final List<Map<String, dynamic>> warehouseItems = [];
  final List<Map<String, dynamic>> pilotStoreItems = [];
  final List<Map<String, dynamic>> rndPoolItems = [];

  Future<void> allocateStockPosting() async {
    // Constructing the payload as per required format
    final payload = {
      "Warehouse": json.encode(warehouseItems.isEmpty ? [] : []),
      "PilotStores":
          json.encode(pilotStoreItems.isEmpty ? [] : pilotStoreItems),
      "RndPool": json.encode(rndPoolItems.isEmpty ? [] : []),
    };

    // Encode PilotStores as a JSON string
    if (pilotStoreItems.isNotEmpty) {
      payload["PilotStores"] = json.encode(pilotStoreItems);
    }

    try {
      final response = await http.post(
        Uri.parse('${ApiService.base}/api/getStockPosting'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
          'Accept': 'application/json, text/plain, */*',
        },
        body: json.encode(payload),
      );

      // Debugging: Print status code and response body
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Stock allocation successfully posted!");
      } else if (response.statusCode == 401) {
        Get.to(() => LoginScreen());
      } else {
        Get.snackbar("Error",
            "Failed to allocate stock. Status: ${response.statusCode}. Response: ${response.body}");
      }
    } catch (error) {
      // Debugging: Print error message
      print("Error: $error");
      Get.snackbar("Error", "Failed to allocate stock. Error: $error");
    }
  }
}
