import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:erp_copy/services/api_service.dart';
import 'package:erp_copy/utils/toast_notify.dart';

class OtpController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> getOtp(String empCode) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse('${ApiService.base}/api/sendLoginOTP'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"empCode": empCode}),
      );

      final Map<String, dynamic> result = jsonDecode(response.body);
      final String message = result['message'];

      if (response.statusCode == 200) {
        toast(message);
      } else {
        toast(message);
        throw Exception(message);
      }
    } finally {
      isLoading(false);
    }
  }
}
