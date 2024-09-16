import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InsertEmployeeDetailsController extends GetxController {
  Future insertEmpDetails(String dept, doj, email, empId, fname, lname,
      loaction, mob, reportingman) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/insertEmployeeDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "department": dept,
        "doj": doj,
        "emailId": email,
        "empId": empId,
        "firstName": fname,
        "lastName": lname,
        "location": loaction,
        "mobileNo": mob,
        "reportingManager": reportingman,
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String message = result['message'];

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
