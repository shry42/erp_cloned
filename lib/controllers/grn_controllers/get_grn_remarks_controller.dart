import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class GetGrnRemarksController extends GetxController {
  var isLoading = false.obs; // Loading state

  Future getGRNRemarks(int GRNTxnID, int ItemID) async {
    isLoading(true); // Start loading
    try {
      http.Response response = await http.post(
        Uri.parse('${ApiService.base}/api/getGRNRemarks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppController.accessToken}',
        },
        body: jsonEncode({
          "GRNTxnID": GRNTxnID,
          "ItemID": ItemID,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        List<dynamic> data = result['data'];

        // Convert data into rows for the DataTable
        List<DataRow> rows = [];
        for (int i = 0; i < data.length; i++) {
          String remark = data[i]['remarks'] ?? 'No remarks';
          String createdAt = data[i]['createdAt'] ?? 'No date';

          // Formatting the date
          DateTime parsedDate = DateTime.parse(createdAt);
          String formattedDate = DateFormat.yMMMd().format(parsedDate);

          rows.add(
            DataRow(
              cells: [
                DataCell(Text((i + 1).toString())), // SR No.
                DataCell(Text(remark)), // Remark
                DataCell(Text(formattedDate)), // Created At
              ],
            ),
          );
        }

        Get.defaultDialog(
          title: 'Remark list',
          content: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('SR NO.')),
                DataColumn(label: Text('Remark')),
                DataColumn(label: Text('Created at')),
              ],
              rows: rows, // Add the generated rows
            ),
          ),
          textConfirm: "Close",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
        );
      } else {
        handleErrorResponse(response);
        return [];
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
      Get.snackbar('Error', 'Failed to fetch GRN items. ${e.toString()}');
      return [];
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Handle error responses (e.g., validation, unauthorized)
  void handleErrorResponse(http.Response response) {
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
        middleText: "$message \nPlease re-login",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.offAll(LoginScreen()); // Redirect to login
        },
      );
    }
  }
}
