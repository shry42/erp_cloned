import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/pr_models/department_filter_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DepartmentFiterController extends GetxController {
  List<DepartmentFilterModel> depFilterList = [];

  Future<List<DepartmentFilterModel>> fetchFilterDepList(
      String newValue) async {
    final response = await http.post(
      Uri.parse('${ApiService.base}/api/getPendingList'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        // "Department": AppController.Department,
        "Department": newValue,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> dataLists = jsonResponse['data'];
      depFilterList = dataLists
          .map((item) => DepartmentFilterModel.fromJson(item))
          .toList();

      return depFilterList;
    } else {
      if (response.statusCode == 401) {
        toast('session expired or invalid');
        Get.offAll(LoginScreen());
      }
      // throw Exception('Failed to fetch data');
      return depFilterList = [];
    }
  }
}
