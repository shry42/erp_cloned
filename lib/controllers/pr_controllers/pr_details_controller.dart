import 'dart:convert';

import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/pr_models/pr_details_by_select_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

class PrDetailsController extends GetxController {
  List<PrDetailsBySelectModel> prDetailBySel = [];
  RxList prDetails = [].obs;

  Future getPrDetails(String PrTxnId) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getPRDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: jsonEncode({"PRTxnID": PrTxnId}),
    );
    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        toast('session expired or invalid');
        Get.offAll(LoginScreen());
      }
      Map<String, dynamic> result = jsonDecode(response.body);
      String message = result['message'];
      AppController.setmessage(message);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      AppController.setmessage(null);

      List<dynamic> data = result['data'];
      prDetailBySel =
          data.map((item) => PrDetailsBySelectModel.fromJson(item)).toList();

      prDetails.value =
          data.map((item) => PrDetailsBySelectModel.fromJson(item)).toList();

      return prDetailBySel;
    }
  }
}
