import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/po_models/po_log_model.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class PoLogDetailsController extends GetxController {
  List<PoLogModel> poLogObjList = [];

  Future getPoLogDetails() async {
    http.Response response = await http.get(
      Uri.parse("${ApiService.base}/api/getUnapprovedPOList"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      List<dynamic> data = result['data'];
      poLogObjList = data.map((e) => PoLogModel.fromJson(e)).toList();
      return poLogObjList;
    }
  }
}
