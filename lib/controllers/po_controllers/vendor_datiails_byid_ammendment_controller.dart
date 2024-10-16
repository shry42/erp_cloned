import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/po_models/vendor_detiails_by_id_ammendment_model.dart';
import 'package:erp_copy/screens/loginscreen.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VendorDatiailsByidAmmendmentController extends GetxController {
  List<VendorDetailsByIdAmendmentModel> PoVendorDetailsObjList = [];

  Future getVendorById(String VendorID) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getVendorDetailsById'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: jsonEncode({"VendorID": VendorID}),
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
      PoVendorDetailsObjList =
          data.map((e) => VendorDetailsByIdAmendmentModel.fromJson(e)).toList();
      return PoVendorDetailsObjList;
    }
  }
}
