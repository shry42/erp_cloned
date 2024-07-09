import 'dart:convert';
import 'package:erp_copy/controllers/app_controller.dart';
import 'package:erp_copy/models/po_models/po_vendor_details_model.dart';
import 'package:erp_copy/services/api_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VenodorDetailsController extends GetxController {
  List<VendorDetailsModel> PoVendorDetailsObjList = [];

  Future getVendorById(String VendorID, String POTxnID) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.base}/api/getVendorDetailsByIdAllDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: jsonEncode({"VendorID": VendorID, "POTxnID": POTxnID}),
    );

    if (response.statusCode != 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      String message = result['message'];
      AppController.setmessage(message);
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      AppController.setmessage(null);
      List<dynamic> data = result['data'];
      PoVendorDetailsObjList =
          data.map((e) => VendorDetailsModel.fromJson(e)).toList();
      return PoVendorDetailsObjList;
    }
  }
}
