import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/pr_models/department_list_model.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DepartmentListController extends GetxController {
  List<DepartmentListModel> depList = [];
  dynamic departmentDefault;

  Future<List<DepartmentListModel>> fetchDepList() async {
    final response = await http.get(
      Uri.parse('${ApiService.base}/api/getDepartment'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> dataLists = jsonResponse['data'];
      depList =
          dataLists.map((item) => DepartmentListModel.fromJson(item)).toList();
      departmentDefault = depList[0];
      return depList;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
