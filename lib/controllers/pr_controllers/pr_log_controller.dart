import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/pr_models/pr_log_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PrLogController extends GetxController {
  List<PrLogModel> prLogObj = [];

  Future getPrDetails() async {
    http.Response response = await http.get(
      Uri.parse('${ApiService.base}/api/getPRLog'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      List<dynamic> data = result['data'];
      prLogObj = data.map((item) => PrLogModel.fromJson(item)).toList();
      return prLogObj;
    } else if (response.statusCode == 401) {
      if (response.statusCode == 401) {
        toast('session expired or invalid');
        Get.offAll(LoginScreen());
      }
      toast('unauthorized');
      Get.offAll(LoginScreen());
    }
  }
}
